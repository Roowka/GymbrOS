import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Exercise/exerciseComment_model.dart';

class ExerciseCommentDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertExerciseComment(ExerciseComment exerciseComment) async {
    print('Inserting exercise comment...');
    try {
      final db = await _getDB();
      return await db.insert(
        'ExerciseComment',
        exerciseComment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting exercise comment: $e');
      return -1;
    }
  }

  Future<List<ExerciseComment>> getExerciseComments() async {
    print('Getting exercise comments...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> commentMaps =
          await db.query('exerciseComment');
      return commentMaps.map((map) => ExerciseComment.fromMap(map)).toList();
    } catch (e) {
      print('Error getting exercise comments: $e');
      return [];
    }
  }

  Future<bool> updateExerciseComment(ExerciseComment exerciseComment) async {
    print('Updating exercise comment...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'exerciseComment',
        exerciseComment.toMap(),
        where: 'id = ?',
        whereArgs: [exerciseComment.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating exercise comment: $e');
      return false;
    }
  }

  Future<bool> deleteExerciseComment(int id) async {
    print('Deleting exercise comment...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'exerciseComment',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting exercise comment: $e');
      return false;
    }
  }

  Future<bool> deleteAllExerciseComments() async {
    print('Deleting all exercise comments...');
    try {
      final db = await _getDB();
      await db.delete('exerciseComment');
      return true;
    } catch (e) {
      print('Error deleting all exercise comments: $e');
      return false;
    }
  }
}
