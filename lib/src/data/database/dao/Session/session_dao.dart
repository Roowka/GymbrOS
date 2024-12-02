import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Session/session_model.dart';

class SessionDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertSession(Session session) async {
    print('Inserting session...');
    try {
      final db = await _getDB();
      return await db.insert(
        'Session',
        session.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting session: $e');
      return -1;
    }
  }

  Future<List<Session>> getSessions() async {
    print('Getting sessions...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> sessionMaps = await db.query('session');
      return sessionMaps.map((map) => Session.fromMap(map)).toList();
    } catch (e) {
      print('Error getting sessions: $e');
      return [];
    }
  }

  Future<List<Session>> getSessionsByType(SessionType type) async {
    print('Getting sessions by type...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> sessionMaps = await db.query(
        'session',
        where: 'type = ?',
        whereArgs: [type.toString().split('.').last],
      );
      return sessionMaps.map((map) => Session.fromMap(map)).toList();
    } catch (e) {
      print('Error getting sessions by type: $e');
      return [];
    }
  }

  Future<bool> updateSession(Session session) async {
    print('Updating session...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'session',
        session.toMap(),
        where: 'id = ?',
        whereArgs: [session.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating session: $e');
      return false;
    }
  }

  Future<bool> deleteSession(int id) async {
    print('Deleting session...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'session',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting session: $e');
      return false;
    }
  }

  Future<bool> deleteAllSessions() async {
    print('Deleting all sessions...');
    try {
      final db = await _getDB();
      await db.delete('session');
      return true;
    } catch (e) {
      print('Error deleting all sessions: $e');
      return false;
    }
  }
}
