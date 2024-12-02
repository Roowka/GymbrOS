import 'package:flutter/material.dart';
import 'package:gymbros/src/features/providers/seance_provider.dart';
import 'package:gymbros/src/home.dart';
import 'package:provider/provider.dart';
import 'src/layout.dart';
import 'src/data/database/db_helper.dart';
import 'src/data/database/dao/user_dao.dart';
import 'src/data/database/models/user_model.dart';
import 'src/data/database/models/Session/sessionComment_model.dart';
import 'src/data/database/models/Exercise/exercise_model.dart';
import 'src/data/database/models/program_model.dart';
import 'src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:gymbros/src/features/providers/seance_provider.dart';

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
  // final comments = await commentDAO.comments();
  // for (final comment in comments) {
  //   print(comment.text);
  // }
  // final exercises = await exerciseDAO.exercises();
  // for (final exercise in exercises) {
  //   print(exercise.name);
  // }
  // final programs = await programDAO.programs();
  // for (final program in programs) {
  //   print(program.name);
  // }
  // final sessions = await sessionDAO.sessions();
  // for (final session in sessions) {
  //   print(session.name);
  // }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProgramProvider()),
      ChangeNotifierProvider(create: (_) => SessionProvider()),
    ],
    child: MyApp(),
  ));
}
