import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/screens/register_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/congratulation_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/training_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/traning_preview_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/filter_screen.dart';
import 'package:musculo_app/modules/onboarding/get_started.dart';
import 'package:musculo_app/modules/onboarding/splash_screen.dart';

class Routes {
  static const String splash = "/";
  static const String getStarted = "/get-started";
  static const String signInscreen = "/sign-in_screen";
  static const String registerscreen = "/register_screen";
  static const String bottomnavigationbarscreen = "/bottom_navigation_screen";
  static const String trainingscreen = "/training_screen";
  static const String congrate = "/congrate_screen";
  static const String filterscreen = "/filter_screen";
  static const String traningpreviewscreen = "/training_preview_screen";
  static const String programdetailscreen = "/program_detail_screen";
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
        return MaterialPageRoute(
          builder: (_) => const BottomNavigationScreen(),
        );
      case Routes.trainingscreen:
        return MaterialPageRoute(builder: (_) => const TrainingScreen());
      case Routes.congrate:
        return MaterialPageRoute(builder: (_) => const CongratulationScreen());
      case Routes.filterscreen:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      case Routes.traningpreviewscreen:
        return MaterialPageRoute(builder: (_) => const TraningPreviewScreen());
      case Routes.programdetailscreen:
        return MaterialPageRoute(builder: (_) => const TraningPreviewScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
