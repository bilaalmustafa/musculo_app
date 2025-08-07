import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/exercise_services.dart';
import 'package:musculo_app/core/services/payment_service.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/sold_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/model/workouts_model.dart';

class DiscoverViewModel extends ChangeNotifier {
  bool isloading = false;
  int selectedRating = 2;
  Future<ProgramModel?> postProgramRatingAndReview(
    String docId,
    double rating,
    int newCount,
    ProgramModel model,
    List<String> reviewList,
  ) async {
    try {
      isloading = true;
      notifyListeners();

      ProgramModel item = model.copyWith(
        rating: rating,
        review: reviewList,
        ratingCount: newCount,
      );

      await instance<ProgramServices>().ratingCreate(docId, item);

      isloading = false;
      notifyListeners();
      return item;
    } catch (e) {
      log("discoveError $e");
      isloading = false;
      notifyListeners();
      return null;
    }
  }

  selectStart(int value) {
    selectedRating = value;
    notifyListeners();
  }

  double getingRating(final double oldRating, int oldCount) {
    final double newRating =
        ((oldRating * oldCount) + selectedRating) / (oldCount + 1);
    return newRating;
  }

  Future<WorkoutModel?> postWorkoutRatingAndReview(
    String docId,
    double rating,
    int newCount,
    WorkoutModel model,
    List<String> reviewList,
  ) async {
    try {
      isloading = true;
      notifyListeners();

      WorkoutModel item = model.copyWith(
        rating: rating,
        review: reviewList,
        ratingCount: newCount,
      );

      await instance<WorkoutServices>().workoutratingCreate(docId, item);

      isloading = false;
      notifyListeners();
      return item;
    } catch (e) {
      log("discoveError $e");
      isloading = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel?> parchaseWorkout(
    String uid,
    UserModel userModel,
    List<WorkoutModel> workoutItem,
  ) async {
    try {
      isloading = true;
      notifyListeners();
      UserModel userdate = userModel.copyWith(listOfWorkouts: workoutItem);

      // Call the purchase API or service here
      final result = await instance<UserService>().updateData(uid, userdate);

      isloading = false;
      notifyListeners();
      return result;
    } catch (e) {
      log("purchaseError $e");
      isloading = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel?> parchaseProgram(
    String uid,
    UserModel userModel,
    List<ProgramModel> programItem,
  ) async {
    try {
      isloading = true;
      notifyListeners();
      UserModel userdate = userModel.copyWith(listOfPrograms: programItem);

      // Call the purchase API or service here
      final result = await instance<UserService>().updateData(uid, userdate);

      isloading = false;
      notifyListeners();
      return result;
    } catch (e) {
      log("purchaseError $e");
      isloading = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel?> addSoldInList(
    String uid,
    UserModel userModel,
    List<SoldModel> soldItem,
  ) async {
    try {
      isloading = true;
      notifyListeners();
      UserModel userdate = userModel.copyWith(sold: soldItem);

      // Call the purchase API or service here
      final result = await instance<UserService>().updateData(uid, userdate);

      isloading = false;
      notifyListeners();
      return result;
    } catch (e) {
      log("purchaseError $e");
      isloading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> payPayment(String email, double amount) async {
    try {
      isloading = true;
      notifyListeners();

      // Simulate a payment process
      final ispaymentSuccessful = await instance<PaymentService>()
          .initPaymentSheet(email: email, amount: amount);

      isloading = false;
      notifyListeners();
      return ispaymentSuccessful; // Payment successful
    } catch (e) {
      log("Payment error: $e");
      isloading = false;
      notifyListeners();
      return false; // Payment failed
    }
  }
}
