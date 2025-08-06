import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permissions (especially for iOS)
    await _messaging.requestPermission();

    // Android local notification setup
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Triggered when user taps notification
        print('🔔 Notification Tapped: ${response.payload}');
      },
    );

    // Foreground handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📨 Foreground: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    // When user taps on notification (background or terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📲 App opened from notification: ${message.notification?.title}');
      // Navigate or do any logic here
    });

    // Optional: Handle app opened from terminated state
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print('⏰ App launched from terminated by tap: ${initialMessage.notification?.title}');
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel', // same as AndroidManifest
      'Default Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
  }
}
