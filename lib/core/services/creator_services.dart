import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/programs.dart';

class CreatorServices extends FirebaseService<ProgramModel> {
  CreatorServices()
    : super(
        collectionName: "discovery",
        fromJson: ProgramModel.fromJson,
        toJson: (programs) => {...programs.toJson(), "type": "Program"},
      );

  Future<bool> createDiscovery(String id, ProgramModel item) async {
    return create(id, item);
  }

  Stream<List<ProgramModel>> getPrograms() => getAllDiscovery("Program");
  Stream<List<ProgramModel>> getWorkout() => getAllDiscovery("Workout");
}
