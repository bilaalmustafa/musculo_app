import 'package:flutter/material.dart';

class DiscoverFilter extends ChangeNotifier {
  // ------------- Actual applied filter -------------
  int planType = 0;
  int gender = 0;
  bool premium = false;
  RangeValues price = const RangeValues(0, 500);
  RangeValues length = const RangeValues(1, 60);
  double difficulty = 0;
  bool isFilterApplied = false;

  // ------------- “search” -------------
  String _query = '';
  String get query => _query;
  void setQuery(String value) {
    final cleaned = value.trim();
    if (cleaned == _query) return;
    _query = cleaned;
    notifyListeners();
  }

  // ------------- Temporary  filter values -------------
  int tempPlanType = 0;
  int tempGender = 0;
  bool tempPremium = false;
  RangeValues tempPrice = const RangeValues(0, 500);
  RangeValues tempLength = const RangeValues(1, 60);
  double tempDifficulty = 0;
  String tempQuery = '';

  // ------------- setters for temp values -------------
  void setTempPlanType(int i) {
    tempPlanType = i;
    notifyListeners();
  }

  void setTempGender(int i) {
    tempGender = i;
    notifyListeners();
  }

  void setTempPremium(bool v) {
    tempPremium = v;
    notifyListeners();
  }

  void setTempPrice(RangeValues v) {
    tempPrice = v;
    notifyListeners();
  }

  void setTempLength(RangeValues v) {
    tempLength = v;
    notifyListeners();
  }

  void setTempDifficulty(double v) {
    tempDifficulty = v;
    notifyListeners();
  }

  void applyFilterFlag() {
    isFilterApplied = true;
    notifyListeners();
  }

  // ------------- Apply temporary values to actual filters -------------
  void applyFilters() {
    planType = tempPlanType;
    gender = tempGender;
    premium = tempPremium;
    price = tempPrice;
    length = tempLength;
    difficulty = tempDifficulty;
    notifyListeners();
  }

  // ------------- Reset temporary values from applied filters -------------
  void resetTemp() {
    tempPlanType = planType;
    tempGender = gender;
    tempPremium = premium;
    tempPrice = price;
    tempLength = length;
    tempDifficulty = difficulty;
  }

  // ------------- clear -------------
  void clear() {
    planType = gender = 0;
    premium = false;
    price = const RangeValues(0, 500);
    length = const RangeValues(1, 60);
    difficulty = 0;
    _query = '';
    isFilterApplied = false;
    resetTemp();
    notifyListeners();
  }
}
