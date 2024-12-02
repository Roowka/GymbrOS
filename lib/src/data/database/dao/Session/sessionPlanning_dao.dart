import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Session/sessionPlanning_model.dart';

class SessionPlanningDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertSessionPlanning(SessionPlanning planning) async {
    print('Inserting session planning...');
    try {
      final db = await _getDB();
      return await db.insert(
        'SessionPlanning',
        planning.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting session planning: $e');
      return -1;
    }
  }

  Future<List<SessionPlanning>> getSessionPlannings() async {
    print('Getting session plannings...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> planningMaps =
          await db.query('sessionPlanning');
      return planningMaps.map((map) => SessionPlanning.fromMap(map)).toList();
    } catch (e) {
      print('Error getting session plannings: $e');
      return [];
    }
  }

  Future<List<SessionPlanning>> getPlanningsByUserId(int userId) async {
    print('Getting plannings for user ID: $userId...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> planningMaps = await db.query(
        'sessionPlanning',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      return planningMaps.map((map) => SessionPlanning.fromMap(map)).toList();
    } catch (e) {
      print('Error getting plannings for user ID: $e');
      return [];
    }
  }

  Future<List<SessionPlanning>> getPlanningsByDate(DateTime date) async {
    print('Getting plannings for date: $date...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> planningMaps = await db.query(
        'sessionPlanning',
        where: 'date = ?',
        whereArgs: [date.toIso8601String()],
      );
      return planningMaps.map((map) => SessionPlanning.fromMap(map)).toList();
    } catch (e) {
      print('Error getting plannings for date: $e');
      return [];
    }
  }

  Future<bool> updateSessionPlanning(SessionPlanning planning) async {
    print('Updating session planning...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'sessionPlanning',
        planning.toMap(),
        where: 'id = ?',
        whereArgs: [planning.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating session planning: $e');
      return false;
    }
  }

  Future<bool> deleteSessionPlanning(int id) async {
    print('Deleting session planning...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'sessionPlanning',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting session planning: $e');
      return false;
    }
  }

  Future<bool> deleteAllSessionPlannings() async {
    print('Deleting all session plannings...');
    try {
      final db = await _getDB();
      await db.delete('sessionPlanning');
      return true;
    } catch (e) {
      print('Error deleting all session plannings: $e');
      return false;
    }
  }
}
