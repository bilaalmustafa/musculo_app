import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_%20model.dart';

class DiscoverViewModel extends ChangeNotifier {
  bool isloading = false;
  int selectedRating = 2;
  Future<ProgramModel?> giveRatingAndReview(
    String docId,
    double rating,
    int newCount,
    ProgramModel programModel,
    List<String> reviewList,
  ) async {
    try {
      isloading = true;
      notifyListeners();

      ProgramModel item = programModel.copyWith(
        rating: rating,
        review: reviewList,
        ratingCount: newCount
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
}
