import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:path_provider/path_provider.dart';

class MainMethod {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey =
        "pk_test_51MikpdSDuIYZV8eSumHPQGsTZUGIbUKMM6oqAVt8yPDgjDWb9h659J2y0fE5tuhdxfPgFEbgeP2zNrER1UeGUOBb007fiSXgWU";
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(WorkoutModelAdapter());
    Hive.registerAdapter(VideoModelAdapter());
    Hive.registerAdapter(ProgramModelAdapter());
    initlocator();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
