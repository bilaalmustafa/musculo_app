import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/myApp.dart';
import 'package:musculo_app/core/services/notification_services.dart';
import 'package:musculo_app/core/utils/main_method.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  MainMethod.init();
  
  runApp(const MyApp());
}
