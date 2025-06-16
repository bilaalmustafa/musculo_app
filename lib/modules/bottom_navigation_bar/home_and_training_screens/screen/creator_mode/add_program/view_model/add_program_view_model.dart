import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_%20model.dart';
import 'package:musculo_app/model/workouts_model.dart';

class AddProgramViewModel extends ChangeNotifier {
  bool isLoading = false;
  final TextEditingController programNameController = TextEditingController();
  final TextEditingController addOwnDuraionController = TextEditingController();
  bool isintendedselect = false;
  bool isTypeofProgramSelect = false;
  bool isLevelofProgramslect = false;
  List<WorkoutModel> workoutList = [];

  final formKey = GlobalKey<FormState>();
  String intendedoption = "";
  String typeofProgram = "";
  String levelofProgram = "";
  int? selectedTime;

  bool validateAndSaveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool intededvalidate() {
    if (intendedoption.isNotEmpty == true) {
      return true;
    } else {
      isintendedselect = true;
      notifyListeners();
      return false;
    }
  }

  bool sectectedworksvalidation() {
    if (workoutList.isNotEmpty) {
      return true;
    } else {
      Fluttertoast.showToast(msg: " You haven't Select the workout");
      return false;
    }
  }

  bool typeofProgramvalidate() {
    if (typeofProgram.isNotEmpty == true) {
      return true;
    } else {
      isTypeofProgramSelect = true;
      notifyListeners();
      return false;
    }
  }

  bool levelofProgramsvalidate() {
    if (levelofProgram.isNotEmpty == true) {
      return true;
    } else {
      isLevelofProgramslect = true;
      notifyListeners();
      return false;
    }
  }

  void intendedSelect(String value) {
    intendedoption = value;
    isintendedselect = false;
    notifyListeners();
  }

  void typeofProgrmslect(String value) {
    isTypeofProgramSelect = false;
    typeofProgram = value;
    notifyListeners();
  }

  void levelofProgramselct(String value) {
    levelofProgram = value;
    isLevelofProgramslect = false;
    notifyListeners();
  }

  void workoutSelected(WorkoutModel index) {
    if (workoutList.contains(index)) {
      workoutList.remove(index);
    } else {
      workoutList.add(index);
    }
    notifyListeners();
  }

  Future<bool> creatediscoveryPost(
    String docId,
    String userId,
    String creatorName,
  ) async {
    isLoading = true;
    notifyListeners();
    ProgramModel item = ProgramModel(
      id: userId,
      creatorName: creatorName,
      programName: programNameController.text.trim(),
      typeOf: typeofProgram,
      levelOf: levelofProgram,
      intended: intendedoption,
      listOfWorkouts: workoutList,
      dayAWeek:
          selectedTime != null
              ? selectedTime.toString()
              : addOwnDuraionController.text.trim(),
    );
    bool success = await instance<ProgramServices>().createDiscovery(
      docId,
      item,
    );
    isLoading = false;
    programNameController.clear();
    addOwnDuraionController.clear();
    intendedoption = "";
    typeofProgram = "";
    levelofProgram = "";
    selectedTime = null;
    workoutList.clear();
    notifyListeners();
    return success;
  }
}
