import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/motivational_text_model.dart';

class MotivationalTextService extends FirebaseService<MotivationalTextModel> {
  MotivationalTextService()
    : super(
        collectionName: "motivational_texts",
        fromJson: MotivationalTextModel.fromJson,
        toJson: (motivation) => motivation.toJson(),
      );

  Future<void> createMotivationalText(
    String id,
    MotivationalTextModel motivation,
  ) {
    return create(id, motivation);
  }

  Future<List<MotivationalTextModel>> getAllMotivationalTexts() async {
    return await getAll();
  }

  Future<List<MotivationalTextModel>> getMotivationalTextsbyUID(
    String uID,
  ) async {
    return await getMotivationalTextsByUserId(uID);
  }

  Future<List<MotivationalTextModel>> getRandomMotivationalTexts({
    int limit = 3,
  }) async {
    return await getRandomItems(limit: limit);
  }

  // New method to delete a motivational text
  Future<MotivationalTextModel?> deleteMotivationalText(String id) async {
    return await delete(id);
  }

  // update data method
  Future<void> updateMText(String id, MotivationalTextModel text) {
    return update(id, text);
  }
}
