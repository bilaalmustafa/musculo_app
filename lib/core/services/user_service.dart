import 'package:firebase_auth/firebase_auth.dart';
import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/user_model.dart';

class UserService extends FirebaseService<UserModel> {
  UserService()
      : super(
          collectionName: "users",
          fromJson: UserModel.fromJson,
          toJson: (drug) => drug.toJson(),
        );

  // Future<User?> getUserById(String id) async {
  //   return await getById(id);
  // }

  // Future<List<User>> getUsers() async {
  //   List<User> users = await getAll();
  //   return users;
  // }

  createUser(String id, UserModel item) {
    create(id, item);
  }

  // updateUser(String id, User item) {
  //   update(id, item);
  // }

  // deleteUser(String id) {
  //   delete(id);
  // }
}
