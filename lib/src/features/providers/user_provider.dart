import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/dao/user_dao.dart';
import 'package:gymbros/src/data/database/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final UserDAO _userDAO = UserDAO();

  User? _user;
  User? get user => _user;

  Future<void> loadUser() async {
    final users = await _userDAO.users();
    if (users.isNotEmpty) {
      _user = users.first;
    } else {
      _user = null;
    }
    notifyListeners();
  }

  Future<void> clearUser() async {
    _user = null;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _userDAO.insertUser(user);
    await loadUser();
  }

  Future<void> logoutUser() async {
    _user = null;
    notifyListeners();
  }
}
