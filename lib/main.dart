import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/myApp.dart';
import 'package:musculo_app/core/utils/main_method.dart';
import 'package:musculo_app/firebase_options.dart';

void main() async {
  MainMethod.init();

  runApp(const MyApp());
}
