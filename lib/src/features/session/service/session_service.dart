import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/data/database/models/Exercise/exerciseSession_model.dart';
import 'package:gymbros/src/data/database/dao/Exercise/exercise_dao.dart';
import 'package:gymbros/src/data/database/dao/Exercise/exerciseSession_dao.dart';
import 'package:gymbros/src/data/database/dao/Session/session_dao.dart';

class SessionService {
  Future<String> createSession({
    required Session newSession,
    required List<String> selectedExercises,
    required Map<String, dynamic> exerciseParams,
  }) async {
    if (newSession.name.isEmpty) {
      throw Exception('Le nom de la séance est requis.');
    }

    if (selectedExercises.isEmpty) {
      throw Exception('Vous devez sélectionner au moins un exercice.');
    }

    final sessionDao = SessionDAO();
    final sessionId = await sessionDao.insertSession(newSession);

    if (sessionId == -1) {
      throw Exception('Échec de la création de la séance.');
    }

    final List<ExerciseSession> exerciseSessions = [];

    for (String exercise in selectedExercises) {
      final int repetitions = exerciseParams[exercise]['repetitions'] ?? 0;
      final int series = exerciseParams[exercise]['series'] ?? 0;
      final int rest = exerciseParams[exercise]['rest'] ?? 0;

      final exerciseDao = ExerciseDAO();
      final existingExercises = await exerciseDao.exercises();
      final matchedExercise = existingExercises.firstWhere(
        (e) => e.name == exercise,
        orElse: () =>
            throw Exception('Exercice "$exercise" non trouvé en base'),
      );

      final exerciseSession = ExerciseSession(
        sessionId: sessionId,
        exerciseId: matchedExercise.id!,
        sets: series,
        repetitions: repetitions,
        duration: 0,
        restTime: rest,
      );

      exerciseSessions.add(exerciseSession);
    }

    final exerciseSessionDao = ExerciseSessionDAO();
    for (var es in exerciseSessions) {
      try {
        await exerciseSessionDao.insertExerciseSession(es);
      } catch (e) {
        print('Error inserting exercise session: $e');
      }
    }

    // FOR DEBUG
    final sessions = await sessionDao.getSessions();
    print('-----LES SESSIONS-----');
    for (var session in sessions) {
      print(session.toMap());
    }

    final exerciseSession = await exerciseSessionDao.getExerciseSessions();
    print('-----LES EXERCISESESSIONS-----');
    for (var es in exerciseSession) {
      print(es.toMap());
    }

    return 'Session created successfully';
  }
}
