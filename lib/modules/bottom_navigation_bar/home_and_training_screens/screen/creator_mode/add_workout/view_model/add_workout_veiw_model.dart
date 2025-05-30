import 'package:flutter/material.dart';

class AddWorkoutVeiwModel extends ChangeNotifier {
  String typeofworkout = "";
  List<bool> sectionofWorkout = [false, false, false, false, false];
  double difficulty = 5;
  String selectedhere = "";
  TextEditingController workoutNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
DateTime? selectedDate;
  final formKey = GlobalKey<FormState>();



  void selectHere(String value) {
    selectedhere = value;
    notifyListeners();
  }
 void typeofworkoutselect(String value) {
    typeofworkout = value;
    notifyListeners();
  }
 void sectionofWorkoutselct(bool value, int index) {
    sectionofWorkout[index] = value;
    notifyListeners();
  }

   void difficultySlider(double value) {
    difficulty = value;
    notifyListeners();
  }

   void dateSelecte(DateTime picked) {
    selectedDate = picked;
    dateController.text="${picked.day}/${picked.month}/${picked.year}";
    notifyListeners();
  }
}
