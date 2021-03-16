import 'package:cnode_flutter2/config/storage_manager.dart';
import 'package:cnode_flutter2/models/user_model.dart';
import 'package:flutter/material.dart';

String kUser = 'kUser';

class UserViewModel extends ChangeNotifier {
  UserModel _user;
  UserModel get user => _user;
  bool get hasUser => user != null;
  UserViewModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? UserModel.fromJson(userMap) : null;
  }
  saveUser(UserModel user) async{
    _user = user;
    notifyListeners();
    await StorageManager.localStorage.setItem(kUser, user);
  }

  clearUser() async{
    _user = null;
    notifyListeners();
    await StorageManager.localStorage.deleteItem(kUser);
  }
}
