import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../modules/auth/view_model/forgot_view_model.dart';
import '../../modules/bottom_navigation_bar/feedback/view_model/feedback_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PasswordResetProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
