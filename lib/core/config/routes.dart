import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/screens/register_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/changepassword_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/resetpassword_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/verifypassword_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedb_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedback.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/program_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/congratulation_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/training_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/becomecreator.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/creator_profile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/creatorinfo_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/payment_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/accountinfo.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/myprogramworkout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/user_profile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/creater_screen/notification.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/creater_screen/setting.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/traning_preview_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/filter_screen.dart';
import 'package:musculo_app/modules/onboarding/get_started.dart';
import 'package:musculo_app/modules/onboarding/splash_screen.dart';

import '../../modules/bottom_navigation_bar/profile/user_profile_screens/favorites_screen.dart';
import '../../modules/bottom_navigation_bar/programs_and_workout/user_screen/coach_profile.dart';
import '../../modules/bottom_navigation_bar/programs_and_workout/user_screen/proram_detail_pageview.dart';

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
  static const String settingScreen = "/setting_screen";
  static const String notificationScreen = "/notification_screen";
  static const String userProfileScreen = "/user_profile_screen";
  static const String feedBackScreen = "/feedback_screen";
  static const String accountInfoScreen = "/accountinfo_screen";
  static const String myProgramWorkout = "/myprogramworkout_screen";
  static const String favoriteScreen = "/favorites_screen";
  static const String becomeCreatorScreen = "/becomecreator_screen";
  // static const String programdetailscreen = "/program_detail_screen";
  static const String programDetailPageView = "/program_detail_pageview_screen";
  static const String coachProfile = "/coach_profile_screen";
  static const String creatorInfoScreen = "/creatorinfo_screen";
  static const String paymentScreen = "/payment_screen";
  static const String creatorProfileScreen = "/creator_profile_screen";
  static const String feedbScreen = "/feedb_screen";
  static const String programScreen = "/program_screen";
  static const String resetPasswordScreen = "/resetpassword_screen";
  static const String verifyPasswordScreen = "/verifypassword_screen";
  static const String changePasswordScreen = "/changepassword_screen";
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
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case Routes.userProfileScreen:
        return MaterialPageRoute(builder: (_) => const UserProfile());
      case Routes.feedBackScreen:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
      case Routes.accountInfoScreen:
        return MaterialPageRoute(builder: (_) => const AccountinfoScreen());
      case Routes.myProgramWorkout:
        return MaterialPageRoute(builder: (_) => const Myprogramworkout());
      case Routes.favoriteScreen:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case Routes.becomeCreatorScreen:
        return MaterialPageRoute(builder: (_) => const BecomecreatorScreen());

      case Routes.programDetailPageView:
        return MaterialPageRoute(builder: (_) => const ProgramDetailPageView());
      case Routes.coachProfile:
        return MaterialPageRoute(builder: (_) => const CoachProfile());
      case Routes.creatorInfoScreen:
        return MaterialPageRoute(builder: (_) => const CreatorinfoScreen());
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.creatorProfileScreen:
        return MaterialPageRoute(builder: (_) => const CreatorProfileScreen());
      case Routes.feedbScreen:
        final args = routeSitting.arguments as Map<String, dynamic>;
        final feedbackType = args['feedbackType'] as String;
        return MaterialPageRoute(
          builder: (_) => FeedBScreen(feedbackType: feedbackType),
        );

      case Routes.programScreen:
        return MaterialPageRoute(builder: (_) => const ProgramScreen());
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetpasswordScreen());
      case Routes.verifyPasswordScreen:
        return MaterialPageRoute(builder: (_) => const VerifypasswordScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangepasswordScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
