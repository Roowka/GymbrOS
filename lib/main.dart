import 'package:flutter/material.dart';
import 'src/layout.dart';
import 'src/data/database/db_helper.dart';
import 'src/data/database/dao/user_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.openDB();
  final userDAO = UserDAO();
  await userDAO.insertUser();
  runApp(const MyApp());
}
