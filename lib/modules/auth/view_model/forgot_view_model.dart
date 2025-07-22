import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordResetProvider with ChangeNotifier {
  bool isloading = false;

  Future<bool> sendPasswordResetOTP(String email) async {
    try {
      isloading = true;
      notifyListeners();
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'sendPasswordResetOTP',
      );
      final response = await callable.call({'email': email});
      Fluttertoast.showToast(msg: 'OTP sent: ${response.data}');
      print('OTP sent: ${response.data}');
      isloading = false;
      notifyListeners();
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to send OTP: $e');
      log("opt: $e");
      isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyPasswordResetOTP(String email, String otp) async {
    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'verifyPasswordResetOTP',
      );
      final response = await callable.call({'email': email, 'otp': otp});
      print('OTP verified: ${response.data}');
      return true;
    } catch (e) {
      print('Failed to verify OTP: $e');
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword) async {
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
