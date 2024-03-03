import 'package:flutter/material.dart';
import 'package:ova_assignment/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      username: '',
      email: '',
      displayName: '',
      token: '',
      profilePicture: '',
      password: '');
  User get user => _user;
  void setuser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setuserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
