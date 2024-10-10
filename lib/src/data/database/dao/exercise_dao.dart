import '../models/exercise_model.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class ExerciseDao {
  Future<int> insertExercise(Exercise exercise) async {
    print('Inserting exercise...');
    final db = await DBHelper.openDB();
    return await db.insert(
      'exercise',
      Exercise(
              name: exercise.name,
              repetitions: exercise.repetitions,
              sets: exercise.sets,
              difficulty: exercise.difficulty)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Exercise>> Exercises() async {
    print('Fetching exercises...');
    final db = await DBHelper.openDB();

    final List<Map<String, Object?>> exerciseMaps = await db.query('exercise');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'repetitions': repetitions as int,
            'sets': sets as int,
            'difficulty': difficulty as int,
          } in exerciseMaps)
        Exercise(
          id: id,
          name: name,
          repetitions: repetitions,
          sets: sets,
          difficulty: difficulty,
        )
    ];
  }

  Future<void> updateExercise(Exercise exercise) async {
    print('Updating exercise...');
    final db = await DBHelper.openDB();

    await db.update(
      'exercise',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<void> deleteExercise(int id) async {
    print('Deleting exercise...');
    final db = await DBHelper.openDB();

    await db.delete(
      'exercise',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllExercises() async {
    print('Deleting all exercises...');
    final db = await DBHelper.openDB();

    await db.delete(
      'exercise',
    );
  }
}
