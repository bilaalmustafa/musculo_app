import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_model.dart';
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
        ratingCount: newCount
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
}
