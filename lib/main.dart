import 'package:flutter/material.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:gymbros/src/home.dart';
import 'package:provider/provider.dart';
import 'src/layout.dart';
import 'src/data/database/db_helper.dart';
import 'src/data/database/dao/user_dao.dart';
// import 'src/data/database/dao/comment_dao.dart';
// import 'src/data/database/dao/exercise_dao.dart';
// import 'src/data/database/dao/program_dao.dart';
// import 'src/data/database/dao/session_dao.dart';

import 'src/data/database/models/user_model.dart';
import 'src/data/database/models/Session/sessionComment_model.dart';
import 'src/data/database/models/Exercise/exercise_model.dart';
import 'src/data/database/models/program_model.dart';
import 'src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.openDB();
  final userDAO = UserDAO();
  // final commentDAO = CommentDAO();
  // final exerciseDAO = ExerciseDAO();
  // final programDAO = ProgramDAO();
  // final sessionDAO = SessionDAO();
  await userDAO.deleteAllUsers();
  // await commentDAO.deleteAllComments();
  // await exerciseDAO.deleteAllExercises();
  // await programDAO.deleteAllPrograms();
  // await sessionDAO.deleteAllSessions();
  await userDAO.insertUser(User(name: 'Lucas', email: 'test'));
  // await commentDAO
  //     .insertComment(Comment(sessionId: 1, text: "text", type: "type"));
  // await exerciseDAO.insertExercise(
  //     Exercise(name: "Pompes", repetitions: 10, sets: 4, difficulty: 3));
  // await programDAO.insertProgram(Program(
  //     name: "Program de Lulu",
  //     duration: 30,
  //     exercises: [
  //       Exercise(name: "Pompes", repetitions: 10, sets: 4, difficulty: 3)
  //     ]));
  // await sessionDAO.insertSession(Session(
  //     name: "Seance push",
  //     date: "2022-01-01",
  //     duration: 30,
  //     userId: 1,
  //     programId: 1));
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
