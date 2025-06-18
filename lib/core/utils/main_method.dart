import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:path_provider/path_provider.dart';

class MainMethod {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // GetStorage.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(WorkoutModelAdapter());
    Hive.registerAdapter(VideoModelAdapter());

    initlocator();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
