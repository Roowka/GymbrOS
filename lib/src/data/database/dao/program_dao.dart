import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';
import '../models/program_model.dart';

class ProgramDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertProgram(Program program) async {
    print('Inserting program...');
    try {
      final db = await _getDB();
      return await db.insert(
        'Program',
        program.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting program: $e');
      return -1;
    }
  }

  Future<List<Program>> programs() async {
    print('Getting programs...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> programMaps =
          await db.query('program', orderBy: 'name ASC');
      return programMaps.map((map) => Program.fromMap(map)).toList();
    } catch (e) {
      print('Error getting programs: $e');
      return [];
    }
  }

  Future<bool> updateProgram(Program program) async {
    print('Updating program...');
    try {
      final db = await _getDB();

      if (program.id == null) {
        print('Error: Program id is null');
        return false;
      }

      final result = await db.update(
        'program',
        program.toMap(),
        where: 'id = ?',
        whereArgs: [program.id],
      );

      return result > 0;
    } catch (e) {
      print('Error updating program: $e');
      return false;
    }
  }

  Future<bool> deleteProgram(int id) async {
    print('Deleting program...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'program',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting program: $e');
      return false;
    }
  }

  Future<bool> deleteAllPrograms() async {
    print('Deleting all programs...');
    try {
      final db = await _getDB();
      await db.delete('program');
      return true;
    } catch (e) {
      print('Error deleting all programs: $e');
      return false;
    }
  }
}
