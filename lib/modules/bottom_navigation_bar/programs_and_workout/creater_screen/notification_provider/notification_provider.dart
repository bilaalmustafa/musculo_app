import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = true;
  Map<String, bool> notifications = {};

  /// Default notification settings: all false
  static const Map<String, bool> _defaultNotifications = {
    'phoneNotifications': false,
    'emailNotifications': false,
    'programOrWorkoutNameChanged': false,
    'programOrWorkoutPriceUpdated': false,
    'upcomingTrainingReminder': false,
    'refundNotice': false,
    'receiveFeedbackEmail': false,
    'creatorCancelNotice': false,
  };

  /// Load notifications from Firestore or initialize defaults
  Future<void> loadNotifications() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final docRef = _firestore.collection('users').doc(user.uid);
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data['notifications'] != null) {
          notifications = Map<String, bool>.from(
            data['notifications'] as Map<String, dynamic>,
          );
        } else {
          notifications = Map<String, bool>.from(_defaultNotifications);
          await _saveToFirestore(user.uid);
        }
      } else {
        notifications = Map<String, bool>.from(_defaultNotifications);
        await _saveToFirestore(user.uid);
      }
    } catch (e) {
      if (kDebugMode) print('🔥 Error loading notifications: $e');
      notifications = Map<String, bool>.from(_defaultNotifications);
    }

    isLoading = false;
    notifyListeners();
  }

  /// Update a single notification setting
  Future<void> updateNotification(String key, bool value) async {
    final user = _auth.currentUser;
    if (user == null) return;

    notifications[key] = value;
    _applyMasterLogic();

    // Save changes
    notifyListeners();
    await _firestore.collection('users').doc(user.uid).update({
      'notifications': notifications,
    });
  }

  /// Automatically disable child notifications
  void _applyMasterLogic() {
    final phone = notifications['phoneNotifications'] ?? false;
    final email = notifications['emailNotifications'] ?? false;

    // When both are off, turn off all sub notifications
    if (!phone && !email) {
      notifications.updateAll((key, value) {
        if (key != 'phoneNotifications' && key != 'emailNotifications') {
          return false;
        }
        return value;
      });
    }
  }

  /// Save default notifications to Firestore
  Future<void> _saveToFirestore(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'notifications': notifications,
      }, SetOptions(merge: true));
    } catch (e) {
      if (kDebugMode) print('🔥 Error saving notifications: $e');
    }
  }

  bool shouldSendPush(String key) {
    return (notifications['phoneNotifications'] ?? false) &&
        (notifications[key] ?? false);
  }

  bool shouldSendEmail(String key) {
    return (notifications['emailNotifications'] ?? false) &&
        (notifications[key] ?? false);
  }
}
