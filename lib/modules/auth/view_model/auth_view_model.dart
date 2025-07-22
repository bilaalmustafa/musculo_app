import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/config/routes.dart';

import 'package:musculo_app/core/services/account_storage.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/main.dart';

import 'package:musculo_app/model/user_model.dart' as u;
import 'package:musculo_app/model/user_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  final _authServices = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isMale = true;
  int selectedage = 18;
  String fitnessLevel = "Beginner";
  bool isLoading = false;

  User? currentUser;

  AuthViewModel() {
    currentUser = _authServices.currentUser;
  }

  bool validateAndSaveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void gender(bool value) {
    isMale = value;
    notifyListeners();
  }

  void setage(int value) {
    selectedage = value;
    notifyListeners();
  }

  void setfitnesslevel(String value) {
    fitnessLevel = value;
    notifyListeners();
  }

  Future<UserModel?> signUp() async {
    try {
      isLoading = true;
      notifyListeners();

      final HttpsCallable registerUser = FirebaseFunctions.instance
          .httpsCallable('registerUser');
      final userModel = u.UserModel(
        email: emailController.text.trim(),

        name:
            "${firstnameController.text.trim()} ${surenameController.text.trim()}",
        gender: isMale ? "Male" : "Female",
        age: selectedage,
        levelOfFitness: fitnessLevel,
      );

      final HttpsCallableResult response = await registerUser.call({
        ...userModel.toJson(),
        "password": passController.text.trim(),
      });

      // Always set loading to false
      isLoading = false;
      notifyListeners();

      
      if (response.data['success'] == true) {
        final UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim(),
            );
        final User? user = credential.user;
        await AccountStorage.saveCredentials(
          emailController.text.trim(),
          passController.text,
          'email',
          user!.displayName,
          user.photoURL,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('uid', user.uid);

        log('User created successfully: ${response.data['message']}');

        return userModel;
      } else {
        // Handle unsuccessful response
        log('Failed to create user: ${response.data['message']}');
        Fluttertoast.showToast(
          msg: response.data['message'] ?? 'Registration failed',
        );
        return null;
      }
    } on FirebaseFunctionsException catch (e) {
      isLoading = false;
      notifyListeners();

      log("Cloud Function Errorrrr: ${e.code} - ${e.message}");
      if (kDebugMode) {
        print(
          'Cloud Function Error: codeee: ${e.code}, message: ${e.message}, details: ${e.details}',
        );
      }

      Fluttertoast.showToast(msg: e.message ?? 'Something went wrong');
      return null;
    } catch (e) {
      // Handle any other unexpected errors
      isLoading = false;
      notifyListeners();

      log("Unexpected error: $e");
      if (kDebugMode) {
        print('Unexpected error: $e');
      }

      Fluttertoast.showToast(msg: 'An unexpected error occurred');
      return null;
    }
  }

  Future<User?> signIn(String email, String pass) async {
    //   show loading
    isLoading = true;
    notifyListeners();

    //   sign in with email and password
    User? user = await instance<AuthService>().signInWithEmailAndPassword(
      email,
      pass,
    );

    //  get user data profileImageUrl and DisplayName
    if (user != null) {
      currentUser = user;
      String? profileImageUrl;
      String? displayName;

      try {
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          profileImageUrl = userData?['profileImageUrl'];
          displayName = userData?['name'];
        }
      } catch (e) {
        log('Error fetching user data from Firestore: $e');
      }

      //    store data in AccountStorage
      await AccountStorage.saveCredentials(
        email,
        pass,
        'email',
        profileImageUrl,
        displayName,
      );

      //    store user id in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', user.uid);
    }

    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<void> logout() async {
    // show loading
    isLoading = true;
    notifyListeners();

    // signout current user
    await _authServices.signOut();
    currentUser = null;

    isLoading = false;
    notifyListeners();
  }

  Future<String?> getCurrentUserEmail() async {
    return _auth.currentUser?.email;
  }

  Future<void> switchAccount(String email) async {
    // get save credentials
    final creds = await AccountStorage.getCredentials(email);
    if (creds == null) return;
    final storedEmail = creds['email']!;
    final password = creds['password']!;
    final provider = creds['provider'] ?? 'email';
    final profileImageUrl = creds['profileImageUrl'];
    final userName = creds['userName'];

    try {
      final context = navigatorKey.currentContext!;
      switch (provider) {
        // when provider email then fetch updated data from firestore
        case 'email':
          final user = await signIn(storedEmail, password);
          if (user != null) {
            try {
              final userDoc =
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get();

              if (userDoc.exists) {
                final userData = userDoc.data();
                final updatedProfileImageUrl = userData?['profileImageUrl'];
                final updatedDisplayName = userData?['name'];

                // Update stored credentials with fresh data
                await AccountStorage.saveCredentials(
                  storedEmail,
                  password,
                  provider,
                  updatedProfileImageUrl,
                  updatedDisplayName,
                );
              }
            } catch (e) {
              log('Error updating user data: $e');
            }
          }
          break;
        // when login with google
        case 'google':
          await loginWithGoogle(context);
          break;
        // when login with facebook
        case 'facebook':
          await signInWithFacebook(context);
          break;
        default:
          Fluttertoast.showToast(msg: "Unknown provider: $provider");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Switch failed: ${e.toString()}");
    }
  }

  Future<List<String>> getSavedAccounts() async {
    // get saved accounts
    return await AccountStorage.getSavedEmails();
  }

  Future<void> removeAccount(String email) async {
    // delete account code
    await AccountStorage.deleteAccount(email);
    notifyListeners();
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      //     Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      // Check if the login was successful
      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        // Create credential from access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
              loginResult.accessToken!.tokenString,
            );

        // Sign in to Firebase
        final UserCredential userCredential = await _auth.signInWithCredential(
          facebookAuthCredential,
        );
        final User? user = userCredential.user;

        // if user are not null then get facebook userData
        if (user != null) {
          final userData = await FacebookAuth.instance.getUserData();

          // add facebook userData from firestore through userModel
          final userModel = u.UserModel(
            userId: user.uid,
            email: user.email ?? userData["email"] ?? '',
            name: user.displayName ?? userData["name"] ?? '',
            profileImageUrl:
                user.photoURL ?? (userData["picture"]?["data"]?["url"] ?? ''),
            gender: '',
            age: 0,
            levelOfFitness: '',
          );

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toJson(), SetOptions(merge: true));
          currentUser = user;
          notifyListeners();

          //       Save UID and login state to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('uid', user.uid);

          //       if the user Email are not null then save data in Account Storage
          final email = user.email ?? userData["email"];
          if (email != null && email.isNotEmpty) {
            await AccountStorage.saveCredentials(
              email,
              '',
              'facebook',
              userData['picture']?['data']?['url'] ?? '',
              userData['name'] ?? user.displayName,
            );
          }
        }

        //      Navigate to the BottomNavigation screen
        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            Routes.bottomnavigationbarscreen,
          );
        }

        Fluttertoast.showToast(msg: "Facebook sign-in successful!");
      } else if (loginResult.status == LoginStatus.cancelled) {
        Fluttertoast.showToast(msg: "Facebook sign-in cancelled.");
      } else {
        Fluttertoast.showToast(msg: "Facebook sign-in failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      //    Start and get all google user
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //    If the user cancels, googleUser will be null
      if (googleUser == null) {
        log('Google Sign-In was canceled by the user.');
        Fluttertoast.showToast(msg: "Sign-in canceled");
        return;
      }

      //    Request authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      //    Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //    Sign in to Firebase with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      // if user not equall to null then store data in firestore through UserModel
      if (user != null) {
        final userModel = u.UserModel(
          userId: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          profileImageUrl: user.photoURL ?? '',
          gender: '',
          age: 0,
          levelOfFitness: '',
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson(), SetOptions(merge: true));
        currentUser = user;
        notifyListeners();
      }

      // Save UID and login state to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', user!.uid);

      // if Email not null then save data in Account Storage
      if (user.email != null) {
        await AccountStorage.saveCredentials(
          user.email!,
          '',
          'google',
          user.photoURL,
          user.displayName,
        );
      }

      // Navigate to BottomNavigation screen
      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          Routes.bottomnavigationbarscreen,
        );
      }

      Fluttertoast.showToast(msg: "Successfully signed in!");
    } catch (e) {
      log('Error during Google Sign-In: $e');
      Fluttertoast.showToast(msg: 'An error occurred during sign-in.');
    } finally {
      log('googleSign() → finished');
    }
  }
}
