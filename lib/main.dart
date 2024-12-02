import 'package:flutter/material.dart';
import 'src/layout.dart';
import 'src/data/database/db_helper.dart';
import 'src/data/database/dao/user_dao.dart';
import 'src/data/database/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.openDB();
  final userDAO = UserDAO();
  await userDAO.deleteAllUsers();
  await userDAO.insertUser(User(name: 'Julien Tanti le Bg', email: 'test'));
  final users = await userDAO.users();
  for (final user in users) {
    print(user.name);
  }
  runApp(const MyApp());
}
