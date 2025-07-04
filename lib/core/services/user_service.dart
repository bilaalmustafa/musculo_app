import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    try {
      UserModel? result = await update(id, item);

      return result;
    } catch (e) {
      log("Service: update() failed with error: $e");
      rethrow; // Pass the error up the chain
    }
  }
  Future<UserModel?> updateData(String id, UserModel item) async {
    try {
      UserModel? result = await update(id, item);

      return result;
    } catch (e, strc) {
      Fluttertoast.showToast(msg: "error $e   strace $strc");
      log("errror $e");
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
