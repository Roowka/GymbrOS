import 'package:sqflite/sqflite.dart';
import '../../db_helper.dart';
import '../../models/Exercise/exercise_model.dart';

class ExerciseDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertExercise(Exercise exercise) async {
    print('Inserting exercise...');
    try {
      final db = await _getDB();
      return await db.insert(
        'Exercise',
        exercise.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting exercise: $e');
      return -1;
    }
  }

  Future<List<Exercise>> exercises() async {
    print('Getting exercises...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> exerciseMaps =
          await db.query('exercise', orderBy: 'name ASC');
      return exerciseMaps.map((map) => Exercise.fromMap(map)).toList();
    } catch (e) {
      print('Error getting exercises: $e');
      return [];
    }
  }

  Future<bool> updateExercise(Exercise exercise) async {
    print('Updating exercise...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'exercise',
        exercise.toMap(),
        where: 'id = ?',
        whereArgs: [exercise.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating exercise: $e');
      return false;
    }
  }

  Future<bool> deleteExercise(int id) async {
    print('Deleting exercise...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'exercise',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting exercise: $e');
      return false;
    }
  }

  Future<bool> deleteAllExercises() async {
    print('Deleting all exercises...');
    try {
      final db = await _getDB();
      await db.delete('exercise');
      return true;
    } catch (e) {
      print('Error deleting all exercises: $e');
      return false;
    }
  }
}
