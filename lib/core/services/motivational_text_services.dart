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

  // Future<MotivationalTextModel?> getMotivationalTextById(String id) {
  //   return getById(id);
  // }

  // Future<List<MotivationalTextModel>> getAllMotivationalTexts() {
  //   return getAll();
  // }

  // Future<void> updateMotivationalText(String id, MotivationalTextModel motivation) {
  //   return update(id, motivation);
  // }

  // Future<void> deleteMotivationalText(String id) {
  //   return delete(id);
  // }
}
