import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/dao/user_dao.dart';
import 'package:gymbros/src/data/database/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final UserDAO _userDAO = UserDAO();

  User? _user;
  User? get user => _user;

  Future<void> loadUser(String email) async {
    final users = await _userDAO.users();
    for (final user in users) {
      if (user.email == email) {
        _user = user;
        break;
      } else {
        _user = null;
      }
    }
    notifyListeners();
  }

  Future<void> clearUser() async {
    _user = null;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _userDAO.insertUser(user);
    await loadUser(user.email);
  }

  Future<void> logoutUser() async {
    _user = null;
    notifyListeners();
  }
}
