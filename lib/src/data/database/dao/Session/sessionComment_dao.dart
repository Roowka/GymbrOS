import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Session/sessionComment_model.dart';

class SessionCommentDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertSessionComment(SessionComment comment) async {
    print('Inserting session comment...');
    try {
      final db = await _getDB();
      return await db.insert(
        'SessionComment',
        comment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting session comment: $e');
      return -1;
    }
  }

  Future<List<SessionComment>> getSessionComments() async {
    print('Getting session comments...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> commentMaps =
          await db.query('sessionComment');
      return commentMaps.map((map) => SessionComment.fromMap(map)).toList();
    } catch (e) {
      print('Error getting session comments: $e');
      return [];
    }
  }

  Future<List<SessionComment>> getCommentsBySessionPlanningId(
      int sessionPlanningId) async {
    print('Getting comments for session planning ID: $sessionPlanningId...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> commentMaps = await db.query(
        'sessionComment',
        where: 'sessionId = ?',
        whereArgs: [sessionPlanningId],
      );
      return commentMaps.map((map) => SessionComment.fromMap(map)).toList();
    } catch (e) {
      print('Error getting comments for session planning ID: $e');
      return [];
    }
  }

  Future<bool> updateSessionComment(SessionComment comment) async {
    print('Updating session comment...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'sessionComment',
        comment.toMap(),
        where: 'id = ?',
        whereArgs: [comment.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating session comment: $e');
      return false;
    }
  }

  Future<bool> deleteSessionComment(int id) async {
    print('Deleting session comment...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'sessionComment',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting session comment: $e');
      return false;
    }
  }

  Future<bool> deleteAllSessionComments() async {
    print('Deleting all session comments...');
    try {
      final db = await _getDB();
      await db.delete('sessionComment');
      return true;
    } catch (e) {
      print('Error deleting all session comments: $e');
      return false;
    }
  }
}
