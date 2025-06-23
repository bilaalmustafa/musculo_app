
import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/user_model.dart';

class UserViewModel with ChangeNotifier {
  UserModel? userModel;

  bool isLoading = false;

  Future<UserModel?> getUserById(String id) async {
    userModel = await instance<UserService>().userById(id);
    isLoading = false;
    notifyListeners();
    return userModel;
  }


  Future<UserModel?> updateUserData(String id, String uname  , DateTime udob, String ugenger, String ulevel) async {
    isLoading = true;
    notifyListeners();
    userModel = userModel!.copyWith(name: uname , dateOfBirth:udob , gender:ugenger, levelOfFitness:ulevel );
    await instance<UserService>().update(id, userModel!);

    isLoading = false;
    notifyListeners();
    return userModel;
  }
}
