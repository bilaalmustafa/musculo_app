import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/feedback_model.dart';

class FeedbackService extends FirebaseService<FeedbackModel> {
  FeedbackService()
    : super(
        collectionName: "feedback",
        fromJson: FeedbackModel.fromJson,
        toJson: (feedback) => feedback.toJson(),
      );

  Future<void> createFeedback(String id, FeedbackModel feedback) {
    return create(id, feedback);
  }

  // Future<FeedbackModel?> getFeedbackById(String id) {
  //   return getById(id);
  // }

  // Future<List<FeedbackModel>> getAllFeedback() {
  //   return getAll();
  // }

  // Future<void> updateFeedback(String id, FeedbackModel feedback) {
  //   return update(id, feedback);
  // }

  // Future<void> deleteFeedback(String id) {
  //   return delete(id);
  // }
}
