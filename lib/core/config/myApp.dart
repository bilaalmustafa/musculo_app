import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splash,
      
    );
  }
}