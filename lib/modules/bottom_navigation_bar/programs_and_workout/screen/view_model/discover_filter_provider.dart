import 'package:flutter/material.dart';

class DiscoverFilter extends ChangeNotifier {
  // ------------- Actual applied filter -------------
  int planType = 0;
  int gender = 0;
  bool premium = false;
  RangeValues price = const RangeValues(0, 500);
  RangeValues length = const RangeValues(0, 60);
  double difficulty = 10;
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
  RangeValues tempLength = const RangeValues(0, 60);
  double tempDifficulty = 10;
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

  void setTempPremium(bool value) {
    tempPremium = value;
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

  void setTemQuery(String value) {
    tempQuery = value.trim();
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
    _query = tempQuery;
    isFilterApplied = _isAnyFilterActive();
    notifyListeners();
  }

  bool _isAnyFilterActive() {
    return planType != 0 ||
        gender != 0 ||
        premium != false ||
        price != const RangeValues(0, 500) ||
        length != const RangeValues(0, 60) ||
        difficulty != 10 ||
        _query.isNotEmpty;
  }

  // ------------- Reset temporary values from applied filters -------------
  void resetTemp() {
    tempPlanType = planType;
    tempGender = gender;
    tempPremium = premium;
    tempPrice = price;
    tempLength = length;
    tempDifficulty = difficulty;
    tempQuery = _query;
  }

  // ------------- clear -------------
  void clear() {
    planType = gender = 0;
    premium = false;
    price = const RangeValues(0, 500);
    length = const RangeValues(0, 60);
    difficulty = 10;
    _query = '';
    isFilterApplied = false;
    resetTemp();
    notifyListeners();
  }
}
