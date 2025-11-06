import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModeProvider extends ChangeNotifier {
  bool _isCreatorView = false; // default view (false = user view)

  bool get isCreatorView => _isCreatorView;
  static const String _keyPrefix = 'isCreatorView_';
  String? _currentUserId;

  Future<void> loadViewMode(String userId) async {
    _currentUserId = userId;
    final prefs = await SharedPreferences.getInstance();
    _isCreatorView =
        prefs.getBool('$_keyPrefix$userId') ?? false; // default: user view
    notifyListeners();
  }

  Future<void> toggleView(bool value) async {
    if (_currentUserId == null) return; // Ensure user ID is set
    _isCreatorView = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_keyPrefix$_currentUserId', _isCreatorView);
  }

  /// Set mode manually and save it
  Future<void> setView(bool value) async {
    if (_currentUserId == null) return;
    _isCreatorView = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_keyPrefix$_currentUserId', _isCreatorView);
  }

  Future<void> clearMode() async {
    _currentUserId = null;
    _isCreatorView = false;
    notifyListeners();
  }
}
