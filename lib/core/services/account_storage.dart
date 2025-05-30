import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AccountStorage {
  static const _secure = FlutterSecureStorage();

  /// Save credentials securely
  static Future<void> saveCredentials(String email, String password) async {
    await _secure.write(
      key: 'account:$email',
      value: jsonEncode({'email': email, 'password': password}),
    );

    final prefs = await SharedPreferences.getInstance();
    final accounts = prefs.getStringList('accounts') ?? [];
    accounts.remove(email);
    accounts.insert(0, email);

    await prefs.setStringList('accounts', accounts);
  }

  /// Get all saved emails
  static Future<List<String>> getSavedEmails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('accounts') ?? [];
  }

  /// Get credentials for a specific account
  static Future<Map<String, String>?> getCredentials(String email) async {
    final json = await _secure.read(key: 'account:$email');
    if (json == null) return null;
    final data = jsonDecode(json);
    return {'email': data['email'], 'password': data['password']};
  }

  /// Delete account
  static Future<void> deleteAccount(String email) async {
    await _secure.delete(key: 'account:$email');
    final prefs = await SharedPreferences.getInstance();
    final accounts = prefs.getStringList('accounts') ?? [];
    accounts.remove(email);
    await prefs.setStringList('accounts', accounts);
  }

  /// Clear all accounts (for testing)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final emails = prefs.getStringList('accounts') ?? [];
    for (var email in emails) {
      await _secure.delete(key: 'account:$email');
    }
    await prefs.remove('accounts');
  }
}
