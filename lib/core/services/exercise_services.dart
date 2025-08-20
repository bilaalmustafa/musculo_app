import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:musculo_app/core/services/firebase_service.dart';

import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/workouts_model.dart';

class ProgramServices extends FirebaseService<ProgramModel> {
  ProgramServices()
    : super(
        collectionName: "discovery",
        fromJson: ProgramModel.fromJson,
        toJson: (programs) => {...programs.toJson(), "type": "Program"},
      );

  Future<bool> createDiscovery(String id, ProgramModel item) async {
    return create(id, item);
  }

  Future<bool> updateDiscovery(String id, ProgramModel item) async {
    try {
      await update(id, item);
      return true;
    } catch (e, strc) {
      Fluttertoast.showToast(msg: "Error while updating program: $e");
      log("Error $e\nStacktrace $strc");
      return false;
    }
  }

  Future<ProgramModel?> ratingCreate(String id, ProgramModel item) async {
    try {
      ProgramModel? result = await update(id, item);

      return result;
    } catch (e, strc) {
      Fluttertoast.showToast(msg: "error $e   strace $strc");
      log("errror $e");
      rethrow;
    }
  }

  Stream<List<ProgramModel>> getPrograms({String? status}) {
    return getAllDiscovery("Program", status: status);
  }

  Stream<List<ProgramModel>> getCreatorPrograms(String uid, {String? status}) {
    return getAllcreatorExercise('Program', uid, status: status);
  }

  //  =>
  //     getAllcreatorExercise("Program", uid);
}

class WorkoutServices extends FirebaseService<WorkoutModel> {
  WorkoutServices()
    : super(
        collectionName: "discovery",
        fromJson: WorkoutModel.fromJson,
        toJson: (workout) => {...workout.toJson(), "type": "Workout"},
      );

  Future<bool> createDiscovery(String id, WorkoutModel item) async {
    return create(id, item);
  }
  Future<bool> updateDiscovery(String id, WorkoutModel item) async {
    try {
      await update(id, item);
      return true;
    } catch (e, strc) {
      Fluttertoast.showToast(msg: "Error while updating program: $e");
      log("Error $e\nStacktrace $strc");
      return false;
    }
  }


  Stream<List<WorkoutModel>> getWorkout() => getAllDiscovery("Workout");
  Stream<List<WorkoutModel>> getCreatorWorkout(String uid) =>
      getAllcreatorExercise("Workout", uid);

  Future<WorkoutModel?> ratingCreate(String id, WorkoutModel item) async {
    try {
      WorkoutModel? result = await update(id, item);

      return result;
    } catch (e, strc) {
      Fluttertoast.showToast(msg: "error $e   strace $strc");

      rethrow; // Pass the error up the chain
    }
  }

  Future<WorkoutModel?> workoutratingCreate(
    String id,
    WorkoutModel item,
  ) async {
    try {
      WorkoutModel? result = await update(id, item);

      return result;
    } catch (e, strc) {
      Fluttertoast.showToast(msg: "error $e   strace $strc");
      log("errror $e");
      rethrow; // Pass the error up the chain
    }
  }
}
