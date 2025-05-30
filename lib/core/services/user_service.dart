import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/user_model.dart';

class UserService extends FirebaseService<UserModel> {
  UserService()
    : super(
        collectionName: "users",
        fromJson: UserModel.fromJson,
        toJson: (user) => user.toJson(),
      );

  Future<UserModel?> userById(String id) async {
    return await getById(id);
  }

  // Future<List<User>> getUsers() async {
  //   List<User> users = await getAll();
  //   return users;
  // }

  createUser(String id, UserModel item) {
    create(id, item);
  }


  Future<UserModel?> serviceUpdate(String id, UserModel item) async {
  log("Service: update() called for ID: $id");
  try {
    UserModel? result = await updateUser(id, item);
    log("Service: update() completed successfully");
    return result;
  } catch (e) {
    log("Service: update() failed with error: $e");
    rethrow; // Pass the error up the chain
  }
}

  // update(String id, UserModel item) {
  //   updateUser(id, item);
  // }

  // deleteUser(String id) {
  //   delete(id);
  // }
}
