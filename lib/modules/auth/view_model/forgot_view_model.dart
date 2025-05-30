import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PasswordResetProvider with ChangeNotifier {
  String _email = '';
  bool _otpSent = false;
  bool _otpVerified = false;
  bool _loading = false;

  String get email => _email;
  bool get otpSent => _otpSent;
  bool get otpVerified => _otpVerified;
  bool get loading => _loading;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Simple and clean OTP methods
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<String> callSendOtp() async {
    try {
      // Optional: For local testing with Firebase Emulator Suite
      // if (kDebugMode) { // Only set in debug mode
      //   _functions.useFunctionsEmulator(origin: 'http://10.0.2.2:5001'); // Android emulator 'localhost'
      //   // _functions.useFunctionsEmulator(origin: 'http://localhost:5001'); // iOS simulator/Web
      // }

      final HttpsCallable callable = _functions.httpsCallable(
        'sendOtpForPasswordReset',
      );
      print('here asim khan printing email for you $_email');
      final HttpsCallableResult result = await callable.call({'email': _email});

      print('here asim khan printing email for you $_email');

      if (result.data != null && result.data['success'] == true) {
        debugPrint("✅ OTP sent: ${result.data['message']}");
        return result.data['message'] as String;
      } else {
        // This path is less likely if functions throw HttpsError, but good for safety
        debugPrint("❌ OTP send unexpected response: ${result.data}");
        throw Exception('Failed to send OTP with unexpected response.');
      }
    } on FirebaseFunctionsException catch (e) {
      debugPrint('❌ Failed to send OTP: ${e.code} - ${e.message}');
      throw Exception('Failed to send OTP: ${e.message}');
    } catch (e) {
      debugPrint('❌ An unexpected error occurred during OTP send: $e');
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  Future<void> verifyOtp(String otp) async {
    setLoading(true);
    try {
      final callable = _functions.httpsCallable('verifyOtpOnly');
      await callable.call({'email': _email.trim(), 'otp': otp.trim()});

      print("✅ OTP verified");
      _otpVerified = true;
    } catch (e) {
      print('❌ Verify OTP Error: $e');
      rethrow;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> resetPassword(String newPassword) async {
    setLoading(true);
    try {
      final callable = _functions.httpsCallable('resetPassword');
      await callable.call({'email': _email.trim(), 'newPassword': newPassword});

      print("✅ Password reset successful");
    } catch (e) {
      print('❌ Reset Password Error: $e');
      rethrow;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
