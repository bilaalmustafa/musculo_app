import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/main.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/view_model/report_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_filter_provider.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';
import 'package:provider/provider.dart';

import '../../modules/auth/view_model/forgot_view_model.dart';
import '../../modules/bottom_navigation_bar/feedback/view_model/feedback_view_model.dart';
import '../../modules/bottom_navigation_bar/profile/profile_view_model/motivational_view_model.dart';
import '../../modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AddProgramViewModel()),
        ChangeNotifierProvider(create: (_) => AddWorkoutVeiwModel()),
        ChangeNotifierProvider(create: (_) => PasswordResetProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => MotivationalTextProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => DiscoverViewModel()),
        ChangeNotifierProvider(create: (_) => DiscoverFilter()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
        ),

        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}
