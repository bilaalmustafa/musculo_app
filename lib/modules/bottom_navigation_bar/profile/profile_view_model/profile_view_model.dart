import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart';

import 'package:musculo_app/model/workouts_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  Box<WorkoutModel>? _box;
  Box<ProgramModel>? _programBox;

  bool get boxesReady => _box != null && _programBox != null;

  List<WorkoutModel> get favorateWorkout => _box?.values.toList() ?? [];
  List<ProgramModel> get favoriteProgram => _programBox?.values.toList() ?? [];

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
