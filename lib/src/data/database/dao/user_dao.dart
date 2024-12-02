import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';
import '../models/user_model.dart';

class UserDAO {
  Future<Database> _getDB() async => await DBHelper.openDB();

  Future<int> insertUser(User user) async {
    print('Inserting user...');
    try {
      final db = await _getDB();
      return await db.insert(
        'User',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting user: $e');
      return -1;
    }
  }

  Future<List<User>> users() async {
    print('Getting users...');
    try {
      final db = await _getDB();
      final List<Map<String, Object?>> userMaps =
          await db.query('user', orderBy: 'name ASC');
      return userMaps.map((map) => User.fromMap(map)).toList();
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  Future<bool> updateUser(User user) async {
    print('Updating user...');
    try {
      final db = await _getDB();
      final result = await db.update(
        'user',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
      return result > 0;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    print('Deleting user...');
    try {
      final db = await _getDB();
      final result = await db.delete(
        'user',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  Future<bool> deleteAllUsers() async {
    print('Deleting all users...');
    try {
      final db = await _getDB();
      await db.delete('user');
      return true;
    } catch (e) {
      print('Error deleting all users: $e');
      return false;
    }
  }
}
