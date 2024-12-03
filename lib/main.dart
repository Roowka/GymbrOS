import 'package:flutter/material.dart';
import 'package:gymbros/src/features/providers/calendar_provider.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'src/layout.dart';
import 'src/data/database/db_helper.dart';
import 'src/data/database/dao/user_dao.dart';
import 'src/data/database/models/user_model.dart';
import 'src/data/database/dao/Exercise/exercise_dao.dart';
import 'src/data/database/models/Exercise/exercise_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.openDB();
// AJOUT DES EXERCISES
  // final exerciseDAO = ExerciseDAO();

  // await exerciseDAO.insertExercise(Exercise(name: 'Pompes', difficulty: 5));
  // await exerciseDAO.insertExercise(Exercise(name: 'Squats', difficulty: 6));
  // await exerciseDAO.insertExercise(Exercise(name: 'Burpees', difficulty: 7));
  // await exerciseDAO.insertExercise(Exercise(name: 'Planches', difficulty: 7));

// AJOUT USER
  // final userDAO = UserDAO();
  // await userDAO.deleteAllUsers();
  // await userDAO.insertUser(User(
  //     name: 'Julien Tanti le Bg',
  //     email: 'julien@gmail.com',
  //     password: '123456'));
  // final users = await userDAO.users();
  // for (final user in users) {
  //   print(user.name);
  // }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProgramProvider()),
      ChangeNotifierProvider(create: (_) => SessionProvider()),
      ChangeNotifierProvider(create: (_) => CalendarProvider()),
    ],
    child: MyApp(),
  ));
}
