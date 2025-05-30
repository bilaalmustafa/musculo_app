import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/account_storage.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/user_model.dart' as u;

class AuthViewModel with ChangeNotifier {
  final _authServices = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isMale = true;
  int selectedage = 18;
  String fitnessLevel = "Beginner";
  bool isLoading = false;

  User? currentUser;

  AuthViewModel() {
    currentUser = _authServices.currentUser;
  }

  bool validateAndSaveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void gender(bool value) {
    isMale = value;
    notifyListeners();
  }

  void setage(int value) {
    selectedage = value;
    notifyListeners();
  }

  void setfitnesslevel(String value) {
    fitnessLevel = value;
    notifyListeners();
  }

  Future<User?> signUp() async {
    isLoading = true;
    notifyListeners();
    User? user = await _authServices.signUpWithEmailAndPassword(
      emailController.text.trim(),
      passController.text,
    );
    if (user != null) {
      currentUser = user;
      await AccountStorage.saveCredentials(
        emailController.text.trim(),
        passController.text,
      );
      await UserService().createUser(
        user.uid,
        u.UserModel(
          email: emailController.text.trim(),
          name:
              "${firstnameController.text.trim()} ${surenameController.text.trim()} ",
          gender: isMale ? "Male" : "Female",
          age: selectedage,
          levelOfFitness: fitnessLevel,
          userId: user.uid,
          // status: "Pending",
        ),
      );
    }
    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<User?> signIn(String email, String pass) async {
    isLoading = true;
    notifyListeners();
    User? user = await instance<AuthService>().signInWithEmailAndPassword(
      email,
      pass,
    );

    if (user != null) {
      currentUser = user;
      await AccountStorage.saveCredentials(email, pass);
    }

    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await _authServices.signOut();
    currentUser = null;

    isLoading = false;
    notifyListeners();
  }

  Future<String?> getCurrentUserEmail() async {
    return FirebaseAuth.instance.currentUser?.email;
  }

  Future<void> switchAccount(String email) async {
    final creds = await AccountStorage.getCredentials(email);
    if (creds != null) {
      await signIn(creds['email']!, creds['password']!);
      await AccountStorage.saveCredentials(creds['email']!, creds['password']!);
    }
  }

  Future<List<String>> getSavedAccounts() async {
    return await AccountStorage.getSavedEmails();
  }

  Future<void> removeAccount(String email) async {
    await AccountStorage.deleteAccount(email);
    notifyListeners();
  }
}
