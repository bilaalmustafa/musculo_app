import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';

class SplashServices {
  Future<void> splashFunction(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && context.mounted) {
      Navigator.pushReplacementNamed(context, Routes.bottomnavigationbarscreen);
    } else {
      Navigator.pushReplacementNamed(context, Routes.getStarted);
    }
  }
}
