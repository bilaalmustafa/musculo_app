import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  Future<void> splashFunction(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final uid = prefs.getString('uid');

    if (isLoggedIn && uid != null && uid.isNotEmpty && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.bottomnavigationbarscreen,
        (route) => false,
      );
    } else {
      Navigator.pushReplacementNamed(context, Routes.getStarted);
    }
  }
}
