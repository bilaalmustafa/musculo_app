import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/model/motivational_text_model.dart';

import '../../../../core/services/motivational_text_services.dart';

class MotivationalTextProvider with ChangeNotifier {
  final MotivationalTextService _motivationalTextService =
      MotivationalTextService();

  // loading logic
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // motivational text list
  List<MotivationalTextModel> _motivationalTexts = [];
  List<MotivationalTextModel> get motivationalTexts => _motivationalTexts;

  // current index
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // setcurrent index funcion
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // setLoading function
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Submit a new motivational text
  Future<bool> submitMotivationalText({
    required String title,
    required String description,
    required String userId,
  }) async {
    try {
      setLoading(true);
      final docRef =
          FirebaseFirestore.instance.collection('motivational_texts').doc();
      final motivationalTextModel = MotivationalTextModel(
        id: docRef.id,
        title: title,
        description: description,
        userId: userId,
        createdAt: DateTime.now(),
      );

      await _motivationalTextService.createMotivationalText(
        docRef.id,
        motivationalTextModel,
      );

      notifyListeners();

      return true;
    } catch (e) {
      log("Error submitting motivational text: $e");
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Fetch all motivational texts
  Future<void> fetchMotivationalTexts() async {
    try {
      setLoading(true);
      _motivationalTexts =
          await _motivationalTextService.getAllMotivationalTexts();
    } catch (e) {
      _motivationalTexts = []; // Set empty list on error
    } finally {
      setLoading(false);
    }
  }

  // Fetch motivational texts by specific user ID
  Future<void> fetchMotivationalTextsByUserId(String userId) async {
    try {
      setLoading(true);
      _motivationalTexts = await _motivationalTextService
          .getMotivationalTextsbyUID(userId);
      debugPrint(
        "Fetched ${_motivationalTexts.length} motivational texts for user $userId",
      );
    } catch (e) {
      debugPrint("Error fetching motivational texts for user $userId: $e");
      _motivationalTexts = [];
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  /// Fetch random motivational texts for carousel
  Future<void> fetchRandomMotivationalTexts({int limit = 3}) async {
    try {
      setLoading(true);
      _motivationalTexts = await _motivationalTextService
          .getRandomMotivationalTexts(limit: limit);
    } catch (e) {
      debugPrint("Error fetching random motivational texts: $e");
      _motivationalTexts = []; // Set empty list on error
    } finally {
      setLoading(false);
    }
  }

  /// Delete a motivational text
  Future<void> deleteMotivationalText(String id) async {
    try {
      await _motivationalTextService.deleteMotivationalText(id);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to delete');
    }
  }

  // update motivational text
  Future<void> updateMotivationalText(MotivationalTextModel updatedText) async {
    setLoading(true);
    notifyListeners();
    try {
      await _motivationalTextService.updateMText(updatedText.id!, updatedText);
      await fetchMotivationalTexts(); // Refresh list
    } catch (e) {
      Fluttertoast.showToast(msg: 'Update failed: $e');
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  // get motivational text by specific user ID
  Stream<List<MotivationalTextModel>> motivationalTextStream(String userId) {
    return _motivationalTextService.streamMotivationalTextsByUser(userId);
  }
}
