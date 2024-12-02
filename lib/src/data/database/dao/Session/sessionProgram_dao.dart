import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Session/sessionProgram_model.dart';

class SessionProgramDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertSessionProgram(SessionProgram sessionProgram) async {
    print('Inserting session program...');
    try {
      final db = await _getDB();
      return await db.insert(
        'SessionProgram',
        sessionProgram.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting session program: $e');
      return -1;
    }
  }

  Future<List<SessionProgram>> getSessionPrograms() async {
    print('Getting session programs...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> programMaps =
          await db.query('sessionProgram');
      return programMaps.map((map) => SessionProgram.fromMap(map)).toList();
    } catch (e) {
      print('Error getting session programs: $e');
      return [];
    }
  }

  Future<List<SessionProgram>> getProgramsBySessionId(int sessionId) async {
    print('Getting programs for session ID: $sessionId...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> programMaps = await db.query(
        'sessionProgram',
        where: 'sessionId = ?',
        whereArgs: [sessionId],
      );
      return programMaps.map((map) => SessionProgram.fromMap(map)).toList();
    } catch (e) {
      print('Error getting programs for session ID: $e');
      return [];
    }
  }

  Future<List<SessionProgram>> getSessionsByProgramId(int programId) async {
    print('Getting sessions for program ID: $programId...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> programMaps = await db.query(
        'sessionProgram',
        where: 'programId = ?',
        whereArgs: [programId],
      );
      return programMaps.map((map) => SessionProgram.fromMap(map)).toList();
    } catch (e) {
      print('Error getting sessions for program ID: $e');
      return [];
    }
  }

  Future<bool> updateSessionProgram(SessionProgram sessionProgram) async {
    print('Updating session program...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'sessionProgram',
        sessionProgram.toMap(),
        where: 'id = ?',
        whereArgs: [sessionProgram.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating session program: $e');
      return false;
    }
  }

  Future<bool> deleteSessionProgram(int id) async {
    print('Deleting session program...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'sessionProgram',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting session program: $e');
      return false;
    }
  }

  Future<bool> deleteAllSessionPrograms() async {
    print('Deleting all session programs...');
    try {
      final db = await _getDB();
      await db.delete('sessionProgram');
      return true;
    } catch (e) {
      print('Error deleting all session programs: $e');
      return false;
    }
  }
}
