import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/user_model.dart' as u;

class AuthViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isMale = true;
  int selectedage = 18;

  bool validateAndSaveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String fitnessLevel = "Beginner";
  bool isLoading = false;

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
    User? user = await instance<AuthService>().signUpWithEmailAndPassword(
      emailController.text,
      passController.text,
    );
    if (user != null) {
      await instance<UserService>().createUser(
        user.uid,
        u.UserModel(
          email: emailController.text.trim(),
          name:
              "${firstnameController.text.trim()} ${surenameController.text.trim()} ",
          gender: isMale ? "Male" : "Female",
          age: selectedage,
          levelOfFitness: fitnessLevel,
          userid: user.uid,
          status: "Pending",
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
    User? user = await instance<AuthService>().signInWithEmailAndPassword(email, pass);
    isLoading = false;
    notifyListeners();
    return user;
  }
}
