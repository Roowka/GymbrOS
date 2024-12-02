import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Exercise/exerciseSession_model.dart';

class ExerciseSessionDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertExerciseSession(ExerciseSession exerciseSession) async {
    print('Inserting exercise session...');
    try {
      final db = await _getDB();
      return await db.insert(
        'ExerciseSession',
        exerciseSession.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting exercise session: $e');
      return -1;
    }
  }

  Future<List<ExerciseSession>> getExerciseSessions() async {
    print('Getting exercise sessions...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> sessionMaps =
          await db.query('exerciseSession');
      return sessionMaps.map((map) => ExerciseSession.fromMap(map)).toList();
    } catch (e) {
      print('Error getting exercise sessions: $e');
      return [];
    }
  }

  Future<List<ExerciseSession>> getSessionsBySessionId(int sessionId) async {
    print('Getting exercise sessions by session ID...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> sessionMaps = await db.query(
        'exerciseSession',
        where: 'sessionId = ?',
        whereArgs: [sessionId],
      );
      return sessionMaps.map((map) => ExerciseSession.fromMap(map)).toList();
    } catch (e) {
      print('Error getting exercise sessions by session ID: $e');
      return [];
    }
  }

  Future<bool> updateExerciseSession(ExerciseSession exerciseSession) async {
    print('Updating exercise session...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'exerciseSession',
        exerciseSession.toMap(),
        where: 'id = ?',
        whereArgs: [exerciseSession.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating exercise session: $e');
      return false;
    }
  }

  Future<bool> deleteExerciseSession(int id) async {
    print('Deleting exercise session...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'exerciseSession',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting exercise session: $e');
      return false;
    }
  }

  Future<bool> deleteSessionsBySessionId(int sessionId) async {
    print('Deleting exercise sessions by session ID...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'exerciseSession',
        where: 'sessionId = ?',
        whereArgs: [sessionId],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting exercise sessions by session ID: $e');
      return false;
    }
  }

  Future<bool> deleteAllExerciseSessions() async {
    print('Deleting all exercise sessions...');
    try {
      final db = await _getDB();
      await db.delete('exerciseSession');
      return true;
    } catch (e) {
      print('Error deleting all exercise sessions: $e');
      return false;
    }
  }
}
