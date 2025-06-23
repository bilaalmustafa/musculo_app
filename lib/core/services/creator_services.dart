import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/programs_%20model.dart';
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

  Future<ProgramModel?> ratingCreate(String id, ProgramModel item) async {
    try {
      ProgramModel? result = await update(id, item);

      return result;
    } catch (e, Strc) {
      Fluttertoast.showToast(msg: "error $e   strace $Strc");
      log("errror $e");
      rethrow; // Pass the error up the chain
    }
  }

  Stream<List<ProgramModel>> getPrograms() => getAllDiscovery("Program");
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

  Stream<List<WorkoutModel>> getWorkout() => getAllDiscovery("Workout");
  Stream<List<WorkoutModel>> getCreatorWorkout(String uid) =>
      getAllcreatorworkout("Workout", uid);
}
