
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}


class MainMethod {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Stripe.publishableKey =
        "pk_test_51RofpWBkqmbwnoQDkjHKPHdp3Hp3rbajUJY7BxCquGLcl24R45J5EMNpG0MHRd1tDAzuxQ2f5KQYmC6To6iGdcAw00nVSgUuXb";
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(WorkoutModelAdapter());
    Hive.registerAdapter(VideoModelAdapter());
    Hive.registerAdapter(ProgramModelAdapter());
    initlocator();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
