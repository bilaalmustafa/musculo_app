import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:musculo_app/modules/auth/register/screens/message_screen.dart';
 import 'package:cloud_functions/cloud_functions.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provissional Permission');
    } else {
      AppSettings.openAppSettings();
      print('user denied Permission');
    }
  }

  void initLocalNotification(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payLoad) {
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: 'your channel Description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/ic_launcher',
        );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<String> getDevcieToken() async {
    String? token = await messaging.getToken();
    if (token != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fcmToken': token,
        }, SetOptions(merge: true));
      }
    }
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((token) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fcmToken': token,
        }, SetOptions(merge: true));
      }
      
      print('refresh token saved: $token');
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MessageScreen(id: message.data['id']),
        ),
      );
    }
  }



 

// this method used for spacific anouncement for role ,, may be user, creator etc
Future<Map<String, dynamic>> sendRoleBasedNotification({
  required String role,
  required String title,
  required String body,
}) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendNotification');
    final results = await callable.call({
      'role': role,
      'title': title,
      'body': body,
    });
    return results.data as Map<String, dynamic>;
  } catch (e) {
    print('Error sending notification: $e');
    return {'success': false, 'message': e.toString()};
  }
}


// call this fuction to send notification to role 
// Send to all "user" role
// await notificationService.sendRoleBasedNotification(
//   role: 'user',
//   title: 'New Workout Available!',
//   body: 'Check out our latest workout program!',
// );
}
// class NotificationService {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('user granted Permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('user granted provissional Permission');
//     } else {
//       AppSettings.openAppSettings();
//       print('user denied Permission');
//     }
//   }

//   void initLocalNotification(
//     BuildContext context,
//     RemoteMessage message,
//   ) async {
//     var androidInitializationSettings = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//     var iosInitializationSettings = DarwinInitializationSettings();

//     var initializationSetting = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSetting,
//       onDidReceiveNotificationResponse: (payLoad) {
//         handleMessage(context, message);
//       },
//     );
//   }

//   void firebaseInit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       if (kDebugMode) {
//         print(message.notification!.title.toString());
//         print(message.notification!.body.toString());
//         print(message.data.toString());
//         print(message.data['type']);
//         print(message.data['id']);
//       }
//       if (Platform.isAndroid) {
//         initLocalNotification(context, message);
//         showNotification(message);
//       } else {
//         showNotification(message);
//       }
//     });
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(100000).toString(),
//       'High Importance Notification',
//       importance: Importance.max,
//     );
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//           channel.id.toString(),
//           channel.name.toString(),
//           channelDescription: 'your channel Description',
//           importance: Importance.high,
//           priority: Priority.high,
//           ticker: 'ticker',
//           icon: '@mipmap/ic_launcher',
//         );

//     DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );

//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         notificationDetails,
//       );
//     });
//   }

//   Future<String> getDevcieToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }

//   void isTokenRefresh() async {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       print('refresh token');
//     });
//   }

//   Future<void> setupInteractMessage(BuildContext context) async {
//     // when app is terminated
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       handleMessage(context, initialMessage);
//     }

//     // when app is in background
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       handleMessage(context, event);
//     });
//   }

//   void handleMessage(BuildContext context, RemoteMessage message) {
//     if (message.data['type'] == 'msj') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => MessageScreen(id: message.data['id']),
//         ),
//       );
//     }
//   }
// }
