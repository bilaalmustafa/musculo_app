import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/exercise_services.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/model/workouts_model.dart';

class UserViewModel with ChangeNotifier {
  UserModel? userModel;
  int selectedRating = 2;
  bool isLoading = false;
  int selectTab = 1;

  void checkBalance(int value) {
    selectTab = value;
    notifyListeners();
  }

  Future<UserModel?> getUserById(String id) async {
    userModel = await instance<UserService>().userById(id);
    isLoading = false;
    notifyListeners();
    return userModel;
  }

  Stream<UserModel?> getUserByIdstream(String id) {
    isLoading = true;
    notifyListeners();

    return instance<UserService>()
        .userByIdstream(id)
        .map((user) {
          userModel = user;
          isLoading = false;
          notifyListeners();
          return userModel;
        })
        .handleError((error) {
          isLoading = false;
          notifyListeners();
          print('Error fetching user: $error');
        });
  }

  Future<UserModel?> updateUserData({
    String? id,
    String? uname,
    DateTime? udob,
    String? ugenger,
    String? ulevel,
    String? cOveriew,
    String? cExperience,
    String? cGoal,
    String? cExercise,
    String? cPlan,
  }) async {
    isLoading = true;
    notifyListeners();
    userModel = userModel!.copyWith(
      name: uname,
      dateOfBirth: udob,
      gender: ugenger,
      levelOfFitness: ulevel,
      overviewText: cOveriew,
      experienceText: cExperience,
      goalText: cGoal,
      favExercise: cExercise,
      subPlane: cPlan,
    );
    await instance<UserService>().update(id!, userModel!);

    isLoading = false;
    notifyListeners();
    return userModel;
  }

  int cancelCount(UserModel? creatorVm) {
    final cancelledCount =
        creatorVm?.sold.where((item) => item.packegeMode == false).length;
    return cancelledCount ?? 0;
  }

  int soldProgram(UserModel? creatorVm) {
    final cancelledCount =
        creatorVm?.sold.where((item) => item.packegeMode == true).length;
    return cancelledCount ?? 0;
  }

  double getBalance(UserModel? creatorVm) {
    final balance = creatorVm?.sold
        .where((item) => item.packegeMode == true)
        .fold<double>(0.0, (sum, item) => sum + item.contentPrice);
    return balance ?? 0.0;
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

  Stream<List<ProgramModel>> getProgamOfCreatoe(String uid) {
    return instance<ProgramServices>().getCreatorPrograms(uid);
  }

  Stream<List<WorkoutModel>> getWorkOutOfCreator(String uid) {
    return instance<WorkoutServices>().getCreatorWorkout(uid);
  }

  Future<UserModel?> postCreatorRatingAndReview(
    String docId,
    double rating,
    int newCount,
    UserModel model,
    List<String> reviewList,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      UserModel item = model.copyWith(
        rating: rating,
        review: reviewList,
        countRating: newCount,
      );

      await instance<UserService>().updateData(docId, item);

      isLoading = false;
      notifyListeners();
      return item;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
