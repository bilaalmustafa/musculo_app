import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
class MainMethod {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // GetStorage.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    initlocator();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
