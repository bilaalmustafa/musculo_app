import 'package:flutter/material.dart';
import 'package:musculo_app/model/motivational_text_model.dart';

import '../../../../core/services/motivational_text_services.dart';

class MotivationalTextProvider with ChangeNotifier {
  final MotivationalTextService _motivationalTextService =
      MotivationalTextService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<MotivationalTextModel> _motivationalTexts = [];
  List<MotivationalTextModel> get motivationalTexts => _motivationalTexts;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Submit a new motivational text
  Future<bool> submitMotivationalText({
    required String title,
    required String description,
    required String userId,
  }) async {
    try {
      setLoading(true);

      final motivationalTextModel = MotivationalTextModel(
        title: title,
        description: description,
        userId: userId,
        createdAt: DateTime.now(),
      );

      final docId = DateTime.now().millisecondsSinceEpoch.toString();

      await _motivationalTextService.createMotivationalText(
        docId,
        motivationalTextModel,
      );

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint("Error submitting motivational text: $e");
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Fetch all motivational texts
  Future<void> fetchMotivationalTexts() async {
    try {
      setLoading(true);
      _motivationalTexts =
          await _motivationalTextService.getAllMotivationalTexts();
      debugPrint("Fetched ${_motivationalTexts.length} motivational texts");
    } catch (e) {
      debugPrint("Error fetching motivational texts: $e");
      _motivationalTexts = []; // Set empty list on error
    } finally {
      setLoading(false);
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
}
