import 'package:gymbros/src/data/database/models/exercise_model.dart';

import '../models/program_model.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class ProgramDao {
  Future<int> insertProgram(Program program) async {
    print('Inserting program...');
    final db = await DBHelper.openDB();
    return await db.insert(
      'program',
      Program(
              name: program.name,
              duration: program.duration,
              exercises: program.exercises)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Program>> Programs() async {
    print('Fetching programs...');
    final db = await DBHelper.openDB();

    final List<Map<String, Object?>> programMaps = await db.query('program');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'duration': duration as int,
            'exercises': exercises as List<Exercise>,
          } in programMaps)
        Program(
          id: id,
          name: name,
          duration: duration,
          exercises: exercises,
        )
    ];
  }

  Future<void> updateProgram(Program program) async {
    print('Updating program...');
    final db = await DBHelper.openDB();

    await db.update(
      'program',
      program.toMap(),
      where: 'id = ?',
      whereArgs: [program.id],
    );
  }

  Future<void> deleteProgram(int id) async {
    print('Deleting program...');
    final db = await DBHelper.openDB();

    await db.delete(
      'program',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllPrograms() async {
    print('Deleting all programs...');
    final db = await DBHelper.openDB();

    await db.delete(
      'program',
    );
  }
}
