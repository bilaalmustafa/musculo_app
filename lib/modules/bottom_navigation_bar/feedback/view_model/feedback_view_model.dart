import 'package:flutter/material.dart';
import 'package:musculo_app/model/feedback_model.dart';

import '../../../../core/services/feedback_services.dart';

class FeedbackProvider with ChangeNotifier {
  final FeedbackService _feedbackService = FeedbackService();

  // List<FeedbackModel> _feedbackList = [];
  // List<FeedbackModel> get feedbackList => _feedbackList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Submit feedback (create document in Firebase)
  Future<void> submitFeedback({
    required String userId,
    String? contentId,
    required String contentType,
    double? rating,
    String? name,
    String? feedbackMessage,
    String? email,
    String? suggestion,
    String? imageUrl,
  }) async {
    try {
      setLoading(true);
      notifyListeners();

      final model = FeedbackModel(
        userId: userId,
        contentId: contentId,
        contentType: contentType,
        name: name,
        rating: rating,
        feedbackMessage: feedbackMessage,
        email: email,
        suggestion: suggestion,
        imageUrl: imageUrl,
        timestamp: DateTime.now(),
      );
      final feedbackId = DateTime.now().millisecondsSinceEpoch.toString();
      await _feedbackService.createFeedback(feedbackId, model);
    } catch (e) {
      debugPrint("Error submitting feedback: $e");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  /// Load all feedback (optional for admin or dashboard usage)
  // Future<void> fetchAllFeedback() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _feedbackList = await _feedbackService.getAll();
  //   } catch (e) {
  //     debugPrint("Error loading feedback: $e");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  /// Optionally fetch feedback for a specific contentId
  // Future<void> fetchFeedbackForContent(String contentId) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final allFeedback = await _feedbackService.getAll();
  //     _feedbackList = allFeedback.where((f) => f.contentId == contentId).toList();
  //   } catch (e) {
  //     debugPrint("Error filtering feedback: $e");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // void clearFeedback() {
  //   _feedbackList = [];
  //   notifyListeners();
  // }
}
