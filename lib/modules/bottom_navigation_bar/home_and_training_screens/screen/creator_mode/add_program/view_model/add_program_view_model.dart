import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/exercise_services.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/workouts_model.dart';

class AddProgramViewModel extends ChangeNotifier {
  bool isContinueLoading = false;
  bool isAddLaterLoading = false;
  final TextEditingController programNameController = TextEditingController();
  final TextEditingController addOwnDuraionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isintendedselect = false;
  bool isTypeofProgramSelect = false;
  bool isLevelofProgramslect = false;
  double sliderValue = 0;
  String? radioOption;
  final formKey = GlobalKey<FormState>();
  String intendedoption = "";
  String typeofProgram = "";
  String levelofProgram = "";
  int? selectedTime;
  String? _editingProgramId;
  List<WorkoutModel> workoutList = [];
  List<String> get workoutIdList => workoutList.map((w) => w.workoutId!).toList();

  final List<DateTime> _selectedDates = [];

  // Public getter for UI
  List<DateTime> get selectedDates => _selectedDates;

  // Weekdays extracted from selected dates
  List<String> get selectedWeekdays =>
      _selectedDates.map((date) => DateFormat('EEE').format(date)).toList();

  // Function to handle calendar date tap
  void toggleSelectedDate(DateTime date) {
    final maxSelections = (selectedTime ?? 0) + 1;

    if (_selectedDates.contains(date)) {
      _selectedDates.remove(date);
    } else {
      if (_selectedDates.length >= maxSelections) return;
      _selectedDates.add(date);
    }

    notifyListeners(); // Notify UI to rebuild
  }

  void setContinueLoading(bool value) {
    isContinueLoading = value;
    notifyListeners();
  }

  void setAddLaterLoading(bool value) {
    isAddLaterLoading = value;
    notifyListeners();
  }

  void clearSelectedDates() {
    _selectedDates.clear();
    notifyListeners();
  }

  // Called when slider is changed
  void updateSlider(double value) {
    sliderValue = value;
    radioOption = null;
    addOwnDuraionController.clear();
    notifyListeners();
  }

  // Called when text is typed
  void updateTextField(String value) {
    if (value.isNotEmpty) {
      sliderValue = 0;
      radioOption = null;
      notifyListeners();
    }
  }

  // Called when radio option is selected
  void selectRadio(String value) {
    radioOption = value;
    sliderValue = 0;
    addOwnDuraionController.clear();
    notifyListeners();
  }

  // Get the final duration value
  int getFinalDuration() {
    if (sliderValue > 0) {
      return sliderValue.round();
    } else if (addOwnDuraionController.text.isNotEmpty) {
      return int.tryParse(addOwnDuraionController.text) ?? 0;
    } else if (radioOption == "Monthly program") {
      return 30;
    }
    return 0;
  }

  bool validateAddDuratuon() {
    if (getFinalDuration() != 0) {
      return true;
    }
    Fluttertoast.showToast(msg: "Enter duration of Program");
    return false;
  }

  bool validateofSeletedTime() {
    if (selectedTime != null) {
      return true;
    }
    Fluttertoast.showToast(msg: "Select time a week");
    return false;
  }

  bool validateofSeleteddays() {
    final requiredDays = (selectedTime ?? -1) + 1;
    if (_selectedDates.isNotEmpty && _selectedDates.length == requiredDays) {
      return true;
    }
    log("selectedTimeeee ${_selectedDates.length}  $selectedTime");
    Fluttertoast.showToast(msg: "Select day a week");
    return false;
  }

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

  Future<void> loadProgramForEditing(String docId) async {
    _editingProgramId = docId;
    try {
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('discovery') // Correct collection name
              .doc(docId)
              .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        ProgramModel program = ProgramModel.fromJson(data);

        // Populate your view model's state with the fetched data
        programNameController.text = program.programName ?? '';
        intendedoption = program.intended ?? '';
        typeofProgram = program.typeOf ?? '';
        levelofProgram = program.levelOf ?? '';

        // Duration
        if (program.duration != null && program.duration! > 0) {
          addOwnDuraionController.text = program.duration.toString();
          sliderValue = 0; // Reset slider if text is used
          radioOption = null; // Reset radio if text is used
        }
        // Time a week
        if (program.timeAWeek != null) {
          selectedTime = program.timeAWeek! - 1;
        }
        // Day a week
        _selectedDates.clear();
        if (program.dayAWeek != null) {
          // This part requires converting weekday strings back to DateTime objects.
          // Since the calendar view needs a DateTime object, you can't just use the strings.
          // A simple approach is to create dummy dates for the week.
          List<String> weekdays = program.dayAWeek!;
          DateTime now = DateTime.now();
          for (int i = 0; i < 7; i++) {
            DateTime day = now.add(Duration(days: i));
            if (weekdays.contains(DateFormat('EEE').format(day))) {
              _selectedDates.add(day);
            }
          }
        }

        // Price
        priceController.text = program.price?.toString() ?? '0.0';

        // Update the workout list with the existing workouts
        workoutList.clear();
      if (program.listOfWorkoutIds != null) {
        for (String workoutId in program.listOfWorkoutIds!) {
          final workoutDoc = await FirebaseFirestore.instance.collection('discovery').doc(workoutId).get();
          if (workoutDoc.exists) {
            workoutList.add(WorkoutModel.fromJson(workoutDoc.data()!));
          }
        }
      }

        // ... populate other fields like duration, dates, etc.

        notifyListeners();
      }
    } catch (e) {
      print("Error loading program for editing: $e");
      // Handle error gracefully, maybe show a toast
      Fluttertoast.showToast(msg: "Failed to load program.");
    }
  }

  Future<bool> creatediscoveryPost(
    String userId,
    String creatorName, {
    bool addLater = false, // new flag
  }) async {
    String? docIdToUse =
        _editingProgramId ?? DateTime.now().microsecondsSinceEpoch.toString();
    final bool isUpdate = _editingProgramId != null;
    DateTime? createdAt =
        isUpdate
            ? (await instance<ProgramServices>().getById(
              _editingProgramId!,
            ))?.createdAt
            : DateTime.now();
    DateTime? updatedAt = DateTime.now(); // Always update this on any change
    int programTotalTime =
        addLater
            ? 0
            : workoutList.fold(
              0,
              (sum, workout) => sum + (workout.totalTime ?? 0),
            );
    // notifyListeners();

    ProgramModel item = ProgramModel(
      userId: userId,
      programId: docIdToUse,
      creatorName: creatorName,
      programName: programNameController.text.trim(),
      typeOf: typeofProgram,
      levelOf: levelofProgram,
      intended: intendedoption,
      duration: getFinalDuration(),
      listOfWorkoutIds: workoutIdList, 
      timeAWeek: (selectedTime ?? 0) + 1,
      dayAWeek: selectedWeekdays,
      price: double.parse(priceController.text),
      totalTime: programTotalTime,
      status: addLater ? "draft" : "published",
      createdAt: createdAt, // Set createdAt
      updatedAt: updatedAt, // Set updatedAt
    );
    bool success;
    if (isUpdate) {
      // If _editingProgramId exists, we are updating.
      success = await instance<ProgramServices>().updateDiscovery(
        docIdToUse,
        item,
      );
    } else {
      // Otherwise, we are creating a new one.
      success = await instance<ProgramServices>().createDiscovery(
        docIdToUse,
        item,
      );
    }

    if (success) {
      clearData();
    }
    return success;
  }

  String _searchWorkoutQuery = '';
  String get searchWorkoutQuery => _searchWorkoutQuery;

  set searchWorkOutQuery(String query) {
    _searchWorkoutQuery = query.trim();
    notifyListeners();
  }

  void clearData() {
    // Clear text controllers
    programNameController.clear();
    addOwnDuraionController.clear();
    priceController.clear();

    // Reset dropdown/radio selections
    intendedoption = "";
    typeofProgram = "";
    levelofProgram = "";
    selectedTime = null;
    radioOption = null;

    // Reset other values
    sliderValue = 0;
    workoutList.clear();
    _selectedDates.clear();
    _searchWorkoutQuery = "";

    // Reset flags
    isintendedselect = false;
    isTypeofProgramSelect = false;
    isLevelofProgramslect = false;
    _editingProgramId = null;
    // Notify listeners to update the UI
    notifyListeners();
  }

  Future<int> getUserProgramCount(String userId) async {
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('discovery')
            .where('type', isEqualTo: 'Program')
            .where('userId', isEqualTo: userId)
            .get();

    return querySnapshot.docs.length;
  }
}
