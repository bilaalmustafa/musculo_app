import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/screens/register_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/sign_in_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:musculo_app/modules/onboarding/get_started.dart';
import 'package:musculo_app/modules/onboarding/splash_screen.dart';

class Routes {
  static const String splash = "/";
  static const String getStarted = "/get-started";
  static const String signInscreen = "/sign-in_screen";
  static const String registerscreen = "/register_screen";
  static const String bottomnavigationbarscreen = "/bottom_navigation_screen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSitting) {
    switch (routeSitting.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.getStarted:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case Routes.signInscreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.registerscreen:
        return MaterialPageRoute(builder: (_) => const RegisterScren());
        case Routes.bottomnavigationbarscreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigationScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
