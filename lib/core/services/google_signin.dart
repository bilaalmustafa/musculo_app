import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/services/account_storage.dart';
import 'package:musculo_app/model/user_model.dart' as u;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSigninService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialized = false;
  static Future<void> initSignIn() async {
    if (!isInitialized) {
      log('Initializing GoogleSignIn with serverClientId');
      await _googleSignIn.initialize(
        serverClientId:
            '332527150538-q3jsmbvb5lg5b3re3rkj911lqfnjoshp.apps.googleusercontent.com',
      );
      log('GoogleSignIn initialization complete');
    } else {
      log('GoogleSignIn already initialized');
    }
    isInitialized = true;
  }

  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      log('Starting Google Sign-In');
      initSignIn();
      log('GoogleSignIn initialized');
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      log('Retrieving idToken');
      final idToken = googleUser.authentication.idToken;
      log('idToken retrieved: ${idToken != null ? 'present' : 'null'}');
      log('Retrieving authorization client');
      final authorizationClient = googleUser.authorizationClient;
      log('Requesting authorization for scopes: email, profile');
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);
      log(
        'Authorization result: accessToken=${authorization?.accessToken != null ? 'present' : 'null'}',
      );
      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        log('Access token is null, retrying authorization');
        final authrization2 = await authorizationClient.authorizationForScopes([
          'email',
          'profile',
        ]);
        log(
          'Retry authorization result: accessToken=${authrization2?.accessToken != null ? 'present' : 'null'}',
        );
        if (authrization2?.accessToken == null) {
          log('Failed to authorize required scopes');
          throw FirebaseException(
            code: "error",
            message: "Failed to authorize required scopes",
            plugin: "google_sign_in",
          );
        }
        authorization = authrization2;
      }
      log('Creating GoogleAuthProvider credential');
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );
      log('Signing in to Firebase with credential');
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      log('Firebase sign-in result: uid=${userCredential.user?.uid ?? 'null'}');
      final User? user = userCredential.user;
      if (user != null) {
        log('Creating UserModel: uid=${user.uid}, email=${user.email}');
        final userModel = u.UserModel(
          userId: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          profileImageUrl: user.photoURL ?? '',
          gender: '',
          age: 0,
          levelOfFitness: '',
        );
        log('Checking Firestore user document: uid=${user.uid}');
        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        final doccSnapshot = await userDoc.get();
        if (!doccSnapshot.exists) {
          log('User document does not exist, creating new document');
          await userDoc.set(userModel.toJson(), SetOptions(merge: true));
          log('User document created successfully');
        } else {
          log('User document already exists');
        }
        log('Saving login state to SharedPreferences');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('uid', user.uid);
        log('SharedPreferences updated: isLoggedIn=true, uid=${user.uid}');
        if (user.email != null) {
          log('Saving credentials to AccountStorage: email=${user.email}');
          await AccountStorage.saveCredentials(
            user.email!,
            '',
            'google',
            user.photoURL,
            user.displayName,
          );
          log('Credentials saved to AccountStorage');
        }
        if (context.mounted) {
          log('Navigating to bottom navigation bar screen');
          Navigator.pushReplacementNamed(
            context,
            Routes.bottomnavigationbarscreen,
          );
        }
        Fluttertoast.showToast(msg: "Successfully sign in!");
      }
      return userCredential;
    } catch (e) {
      log('Google Sign-In error: $e');
      print("Error signing in with Google: $e");
      rethrow;
    } finally {
      log('Google Sign-In process finished');
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }

  static User? get currentUser => _auth.currentUser;
}
