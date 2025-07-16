import 'package:flutter/material.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/auth/register/screens/register_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/changepassword_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/resetpassword_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/verifypassword_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedb_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedback.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/reportstab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/add_program_pageView.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/add_workout_pageview.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/congratulation_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/training_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode_veiwModel/user_mode_viewModel.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/becomecreator.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/ceator_my_program_workout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/creator_profile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/creatorinfo_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/payment_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/accountinfo.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/motivational_text.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/motivationallist.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/myprogramworkout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/user_profile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/creater_screen/notification.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/creater_screen/setting.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/traning_preview_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/filter_screen.dart';
import 'package:musculo_app/modules/onboarding/get_started.dart';
import 'package:musculo_app/modules/onboarding/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../model/motivational_text_model.dart';
import '../../modules/bottom_navigation_bar/profile/user_profile_screens/favorites_screen.dart';
import '../../modules/bottom_navigation_bar/programs_and_workout/coach/coach_profile.dart';

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

  static const String programDetailPageView = "/program_detail_pageview_screen";
  static const String coachProfile = "/coach_profile_screen";
  static const String addworkoutpageview = "/add_workout_pageview_screen";
  static const String addprogrampageview = "/add_program_pageview_screen";
  static const String creatorInfoScreen = "/creatorinfo_screen";
  static const String paymentScreen = "/payment_screen";
  static const String creatorProfileScreen = "/creator_profile_screen";
  static const String feedbScreen = "/feedb_screen";

  static const String resetPasswordScreen = "/resetpassword_screen";
  static const String verifyPasswordScreen = "/verifypassword_screen";
  static const String changePasswordScreen = "/changepassword_screen";
  static const String reportScreen = "/reporttab_screen";
  static const String motivationalScreen = "/motivational_text_screen";
  static const String motivationalListScreen = "/motivational_list_screen";
  static const String creatorMyProgramWorkout =
      "/creator_my_program_workout_screen";
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
        final args = routeSitting.arguments as Map<String, dynamic>?;
        final int initialMainTabIndex =
            args?['initialMainTabIndex'] as int? ?? 0;
        final int initialHomeScreenSubTab =
            args?['initialHomeScreenSubTab'] as int? ?? 0;
        return MaterialPageRoute(
          builder:
              (_) => BottomNavigationScreen(
                initialMainTabIndex: initialMainTabIndex,
                initialHomeScreenSubTab: initialHomeScreenSubTab,
              ),
        );
      case Routes.trainingscreen:
        final argu = routeSitting.arguments as Map<String, dynamic>;
        final modelData = argu["workoutData"] as dynamic;
        final userModel = argu["userModel"] as UserModel;

        return MaterialPageRoute(
          builder:
              (_) => ChangeNotifierProvider(
                create: (context) => UserModeViewmodel(),
                child: TrainingScreen(
                  modelData: modelData,
                  userModel: userModel,
                ),
              ),
        );
      case Routes.congrate:
        final argu = routeSitting.arguments as Map<String, dynamic>;
        final modelData = argu["workoutData"] as WorkoutModel;
        final userModel = argu["userModel"] as UserModel;
        // final creator = routeSitting.arguments as UserModel;
        return MaterialPageRoute(
          builder:
              (_) => CongratulationScreen(
                creator: userModel,
                workoutData: modelData,
              ),
        );
      case Routes.filterscreen:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      case Routes.traningpreviewscreen:
        final workoutModel = routeSitting.arguments as WorkoutModel;
        return MaterialPageRoute(
          builder: (_) => TraningPreviewScreen(workoutModel: workoutModel),
        );

      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case Routes.userProfileScreen:
        return MaterialPageRoute(builder: (_) => const UserProfile());
      case Routes.feedBackScreen:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
      case Routes.accountInfoScreen:
        return MaterialPageRoute(builder: (_) => AccountinfoScreen());
      case Routes.myProgramWorkout:
        return MaterialPageRoute(builder: (_) => const Myprogramworkout());
      case Routes.creatorMyProgramWorkout:
        return MaterialPageRoute(
          builder: (_) => const CreatorMyprogramworkout(),
        );
      case Routes.favoriteScreen:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case Routes.becomeCreatorScreen:
        return MaterialPageRoute(builder: (_) => const BecomecreatorScreen());

      case Routes.programDetailPageView:
        final programModel = routeSitting.arguments as ProgramModel;
        return MaterialPageRoute(
          builder: (_) => ProgramDetailPageView(programModel: programModel),
        );
      case Routes.coachProfile:
        final userId = routeSitting.arguments as String;
        return MaterialPageRoute(builder: (_) => CoachProfile(userId: userId));
      case Routes.addworkoutpageview:
        return MaterialPageRoute(builder: (_) => const AddWorkoutPageView());
      case Routes.addprogrampageview:
        return MaterialPageRoute(builder: (_) => const AddProgramPageview());
      case Routes.creatorInfoScreen:
        return MaterialPageRoute(builder: (_) => const CreatorinfoScreen());
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.creatorProfileScreen:
        return MaterialPageRoute(builder: (_) => const CreatorProfileScreen());
      case Routes.feedbScreen:
        final args = routeSitting.arguments as Map<String, dynamic>;
        final feedbackType = args['feedbackType'] as String;
        final rating = args["rating"] as double;
        final contentId = args['contentId'] as String;
        final contentName = args['contentName'] as String?;
        return MaterialPageRoute(
          builder:
              (_) => FeedBScreen(
                feedbackType: feedbackType,
                contentId: contentId,
                rating: rating,
                contentName: contentName,
              ),
        );
      case Routes.reportScreen:
        final args = routeSitting.arguments as Map<String, dynamic>;
        final reportType = args['reportType'] as String;
        final rating = args["rating"] as double;
        final contentId = args['contentId'] as String;
        final contentName = args['contentName'] as String?;
        return MaterialPageRoute(
          builder:
              (_) => Reportstab(
                reportType: reportType,
                contentId: contentId,
                rating: rating,
                contentName: contentName,
              ),
        );

      // case Routes.programScreen:
      //   return MaterialPageRoute(builder: (_) => const ProgramScreen());
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetpasswordScreen());
      case Routes.verifyPasswordScreen:
        return MaterialPageRoute(builder: (_) => const VerifypasswordScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangepasswordScreen());
      case Routes.motivationalScreen:
        final args = routeSitting.arguments as MotivationalTextModel?;
        return MaterialPageRoute(
          builder: (_) => MotivationalTextScreen(editableText: args),
        );
      case Routes.motivationalListScreen:
        return MaterialPageRoute(
          builder: (_) => const MotivationalListScreen(),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
