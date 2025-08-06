import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordResetProvider with ChangeNotifier {
  bool isloading = false;
  bool isverified = false;
  final functions = FirebaseFunctions.instance;
  Future<bool> sendOtp(String email) async {
    try {
      isloading = true;
      notifyListeners();
      final result = await functions.httpsCallable('sendOtpIfUserExists').call({
        'email': email,
      });

      log('Success: ${result.data}');
      isloading = false;
      notifyListeners();
      return true;
    } on FirebaseFunctionsException catch (e) {
      log('FirebaseFunctionsException: ${e.code} - ${e.message}');
      isloading = false;
      notifyListeners();
      return false;
    } catch (e) {
      log('General error: $e');
      isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyPasswordResetOTP(String email, String otp) async {
    try {
      isverified = true;
      notifyListeners();
      final result = await functions
          .httpsCallable('verifyPasswordResetOTP')
          .call({'email': email, 'otp': otp});

      log('Success: ${result.data}');
      isverified = false;
      notifyListeners();
      return true;
    } on FirebaseFunctionsException catch (e) {
      log('FirebaseFunctionsException: ${e.code} - ${e.message}');
      isverified = false;
      notifyListeners();
      return false;
    } catch (e) {
      log('General error: $e');
      isverified = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(
    String newPassword,
    String otp,
    String email,
  ) async {
    try {
      isverified = true;
      notifyListeners();
      final result = await functions.httpsCallable('resetPassword').call({
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      });

      log('Success: ${result.data}');
      isverified = false;
      notifyListeners();
      return true;
    } on FirebaseFunctionsException catch (e) {
      log('FirebaseFunctionsException: ${e.code} - ${e.message}');
      isverified = false;
      notifyListeners();
      return false;
    } catch (e) {
      log('General error: $e');
      isverified = false;
      notifyListeners();
      return false;
    }

    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
      print('Password updated successfully');
      return true;
    } catch (e) {
      print('Failed to update password: $e');
      return false;
    }
  }
}
