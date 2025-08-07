import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/creator_premium.dart';

class CreatorPlaneService extends FirebaseService<CreatorPremium> {
  CreatorPlaneService()
    : super(
        collectionName: "creatorpremium",
        fromJson: CreatorPremium.fromJson,
        toJson: (creatorpremium) => creatorpremium.toJson(),
      );

  Future<bool> createCreatorPremium(String id, CreatorPremium premium) {
    return create(id, premium);
  }
}
