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
      log("Response from Cloud Function: ${response.data["success"]}");
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
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        if (user != null) {
          await prefs.setString('uid', user.uid);
        }

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

  // Future<User?> signUp() async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     User? user = await _authServices.signUpWithEmailAndPassword(
  //       emailController.text.trim(),
  //       passController.text.trim(),
  //     );
  //     if (user != null) {
  //       // currentUser = user;
  //       await AccountStorage.saveCredentials(
  //         emailController.text.trim(),
  //         passController.text,
  //       );
  //       await Future.delayed(Duration(seconds: 3)); // short delay
  //       await FirebaseAuth.instance.signOut();

  //     // ✅ 3. Sign in again to ensure token is valid
  //     UserCredential signedIn = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //             email: emailController.text.trim(),
  //             password: passController.text.trim());

  //     User currentUser = signedIn.user!;
  //     await currentUser.getIdToken(true);
  //       final userModel = u.UserModel(
  //         email: emailController.text.trim(),
  //         name:
  //             "${firstnameController.text.trim()} ${surenameController.text.trim()} ",
  //         gender: isMale ? "Male" : "Female",
  //         age: selectedage,
  //         levelOfFitness: fitnessLevel,
  //         userId: user.uid,
  //         // status: "Pending",
  //       );

  //       // Call Cloud Function
  //       final createUserCallable = FirebaseFunctions.instance.httpsCallable(
  //         'createUser',
  //       );
  //       await createUserCallable.call(userModel.toJson());
  //       // await UserService().createUser(user.uid);
  //     }
  //     isLoading = false;
  //     notifyListeners();
  //     return user;
  //   } catch (e) {
  //     log("Error signing up userrrrr: $e");
  //     FlutterError.reportError(
  //       FlutterErrorDetails(
  //         exception: e,
  //         stack: StackTrace.current,
  //         library: 'AuthViewModel',
  //         context: ErrorDescription('Error during user sign up'),
  //       ),
  //     );
  //     isLoading = false;
  //     notifyListeners();
  //     return null;
  //   }
  // }

  Future<User?> signIn(String email, String pass) async {
    isLoading = true;
    notifyListeners();
    User? user = await instance<AuthService>().signInWithEmailAndPassword(
      email,
      pass,
    );

    if (user != null) {
      currentUser = user;
      await AccountStorage.saveCredentials(email, pass, 'email');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', user.uid);
    }

    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await _authServices.signOut();
    currentUser = null;

    isLoading = false;
    notifyListeners();
  }

  Future<String?> getCurrentUserEmail() async {
    return FirebaseAuth.instance.currentUser?.email;
  }

  Future<void> switchAccount(String email) async {
    final creds = await AccountStorage.getCredentials(email);
    if (creds == null) return;
    final storedEmail = creds['email']!;
    final password = creds['password']!;
    final provider = creds['provider'] ?? 'email';
    try {
      final context = navigatorKey.currentContext!;
      switch (provider) {
        case 'email':
          await signIn(storedEmail, password);
          break;
        case 'google':
          await loginWithGoogle(context);
          break;
        case 'facebook':
          await signInWithFacebook(context);
          break;
        default:
          Fluttertoast.showToast(msg: "Unknown provider: $provider");
      }
      await AccountStorage.saveCredentials(storedEmail, password, provider);
    } catch (e) {
      Fluttertoast.showToast(msg: "Switch failed: ${e.toString()}");
    }
  }

  Future<List<String>> getSavedAccounts() async {
    return await AccountStorage.getSavedEmails();
  }

  Future<void> removeAccount(String email) async {
    await AccountStorage.deleteAccount(email);
    notifyListeners();
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      // Trigger the sign-in flow
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

        if (user != null) {
          final userData = await FacebookAuth.instance.getUserData();

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
          // save to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toJson(), SetOptions(merge: true));
          currentUser = user;
          notifyListeners();

          // Save UID and login state to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('uid', user.uid);

          final email = user.email ?? userData["email"];
          if (email != null && email.isNotEmpty) {
            await AccountStorage.saveCredentials(email, '', 'facebook');
          }
        }

        if (context.mounted) {
          // Navigate to the home screen
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
      // Start the interactive sign-in process using the new method
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels, googleUser will be null
      if (googleUser == null) {
        log('Google Sign-In was canceled by the user.');
        Fluttertoast.showToast(msg: "Sign-in canceled");
        return; // Stop the function here
      }

      // Obtain the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

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

      if (user.email != null) {
        await AccountStorage.saveCredentials(user.email!, '', 'google');
      }
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
