import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart';

import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/creator_plane_service.dart';
import 'package:musculo_app/model/creator_premium.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart' as u;

import 'package:musculo_app/model/user_model.dart';

import 'package:musculo_app/model/workouts_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? _user;
  bool isLoading = false;
  UserModel? get user => _user;
  // bool _isUploading = false;
  int? selectPlan;
  final GlobalKey<FormState> formlKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();

  final TextEditingController expController = TextEditingController();

  final TextEditingController goalController = TextEditingController();

  // final ImagePicker _picker = ImagePicker();

  // bool get isUploading => _isUploading;

  Box<WorkoutModel>? _box;
  Box<ProgramModel>? _programBox;

  bool get boxesReady => _box != null && _programBox != null;

  List<WorkoutModel> get favorateWorkout => _box?.values.toList() ?? [];
  List<ProgramModel> get favoriteProgram => _programBox?.values.toList() ?? [];

  void selectPlane(int planNumber) {
    if (selectPlan != planNumber) {
      selectPlan = planNumber;
      notifyListeners();
    }
  }

  Future<bool> creatorPremiumPlane(
    String id,
    String email,
    String card,
    double payment,
  ) async {
    log("creatorId: $id");
log("email: $email");
log("card: $card");
log("payment: $payment");
    try {
      CreatorPremium premium = CreatorPremium(
        creatorId: id,
        creatorName: nameController.text.trim(),
        createDate: DateTime.now(),
        email: email,
        card: card,
        payment: payment,
        paymentStatus: "Compeleted",
      );
      log('Sending to backend: ${premium.toJson()}');

      final created = await instance<CreatorPlaneService>()
          .createCreatorPremium(id, premium);
      return created;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Error: $e");
      log("error: $e");
      return false;
    }
  }

  Future<UserModel?> getCreatorPlan(String uid) async {
    try {
      isLoading = true;
      notifyListeners();
      final HttpsCallable creatorPlane = FirebaseFunctions.instance
          .httpsCallable('creatorPlane');
      final userModel = u.UserModel(
        name: nameController.text.trim(),
        overviewText: overviewController.text.trim(),
        goalText: goalController.text.trim(),
        experienceText: expController.text.trim(),
      );
      final HttpsCallableResult response = await creatorPlane.call({
        ...userModel.toJson(),
        "userid": uid,
      });

      if (response.data['success'] == true) {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Become creator successful");
        nameController.clear();
        overviewController.clear();
        goalController.clear();
        expController.clear();

        return userModel;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool?> cancelCreatorPlan(String uid) async {
    try {
      isLoading = true;
      notifyListeners();
      final HttpsCallable cancelcreatorPlane = FirebaseFunctions.instance
          .httpsCallable('cancelcreatorPlane');
      final HttpsCallableResult response = await cancelcreatorPlane.call({
        "userid": uid,
      });

      if (response.data['success'] == true) {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Cancel cretor subcribtion");
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> initFavoritesForUser(String uid) async {
    final boxName = 'favorite_workouts_$uid';
    final programBoxName = 'favorite_programs_$uid';

    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<WorkoutModel>(boxName);
    } else {
      _box = Hive.box<WorkoutModel>(boxName);
    }

    if (!Hive.isBoxOpen(programBoxName)) {
      _programBox = await Hive.openBox<ProgramModel>(programBoxName);
    } else {
      _programBox = Hive.box<ProgramModel>(programBoxName);
    }
    notifyListeners();
  }

  void addFaverateWorkout(WorkoutModel model) {
    if (_box == null) return;
    final key = _box!.keys.firstWhere(
      (k) => _box!.get(k)?.workoutId == model.workoutId,
      orElse: () => null,
    );

    if (key != null) {
      _box!.delete(key);
    } else {
      _box!.add(model);
    }

    notifyListeners();
  }

  void addFaverateProgram(ProgramModel program) {
    if (_programBox == null) return;
    final key = _programBox!.keys.firstWhere(
      (p) => _programBox!.get(p)?.programId == program.programId,
      orElse: () => null,
    );

    if (key != null) {
      _programBox!.delete(key);
    } else {
      _programBox!.add(program);
    }

    notifyListeners();
  }

  int _selectTab = 0;
  int get selectTab => _selectTab;

  void setTab(int val) {
    _selectTab = val;
    notifyListeners();
  }
}
