import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/data/database/models/Exercise/exerciseSession_model.dart';

class SessionProvider with ChangeNotifier {
  final List<Session> _sessions = [];
  final Map<int, List<ExerciseSession>> _sessionExercises = {};

  List<Session> get sessions => _sessions;

  /// Ajouter une séance
  void addSession(Session session) {
    _sessions.insert(0, session);
    debugPrint('Session added: ${session.toMap()} with ID: ${session.id}');
    notifyListeners();
  }

  /// Ajouter des exercices à une séance
  void addExercisesToSession(int sessionId, List<ExerciseSession> exercises) {
    _sessionExercises[sessionId] = exercises;
    debugPrint('Exercises added for session $sessionId: $exercises');
    notifyListeners();
  }

  /// Récupérer les exercices pour une séance spécifique
  List<ExerciseSession> getExercisesForSession(int sessionId) {
    final exercises = _sessionExercises[sessionId] ?? [];
    debugPrint('Exercises fetched for session $sessionId: $exercises');
    return exercises;
  }
}
