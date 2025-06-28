import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/account_storage.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/user_model.dart' as u;
import 'package:musculo_app/model/user_model.dart';

class AuthViewModel with ChangeNotifier {
  final _authServices = AuthService();

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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
        await AccountStorage.saveCredentials(
          emailController.text.trim(),
          passController.text,
        );

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
      await AccountStorage.saveCredentials(email, pass);
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
    if (creds != null) {
      await signIn(creds['email']!, creds['password']!);
      await AccountStorage.saveCredentials(creds['email']!, creds['password']!);
    }
  }

  Future<List<String>> getSavedAccounts() async {
    return await AccountStorage.getSavedEmails();
  }

  Future<void> removeAccount(String email) async {
    await AccountStorage.deleteAccount(email);
    notifyListeners();
  }
}
