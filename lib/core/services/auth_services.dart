import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Account already exists for that email.");
      } else {
        Fluttertoast.showToast(msg: "Sign up failed : ${e.message}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign up failed : $e");
      throw Exception('Error signing up: $e');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      } else {
        Fluttertoast.showToast(msg: "Signin failed:${e.message}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Signin failed:$e");
      throw Exception('Error signing in: $e');
    }
    return null;
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "Error signing out: $e");
      return false;
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent!";
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }

  Future<int> deleteUserAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        return 2;
      }
      return 0;
    } catch (e) {
      log("Error deleting user account: $e");
      Fluttertoast.showToast(msg: "Error deleting user account: $e");
      return 0;
    }
  }

  Future<void> reauthenticateUser(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
    } catch (e) {
      throw Exception('Error re-authenticating user: $e');
    }
  }
}
