import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';
import '../models/user_model.dart';

class UserDAO {
  Future<int> insertUser() async {
    print('Inserting user...');
    final db = await DBHelper.openDB();
    return await db.insert(
      'User',
      User(name: 'Aurélien', email: 'aurelien@lu.com').toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    final db = await DBHelper.openDB();

    final List<Map<String, Object?>> userMaps = await db.query('user');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'email': email as String,
          } in userMaps)
        User(id: id, name: name, email: email),
    ];
  }

  Future<void> updateUser(User user) async {
    final db = await DBHelper.openDB();

    await db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await DBHelper.openDB();

    await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUsers() async {
    final db = await DBHelper.openDB();

    await db.delete(
      'user',
    );
  }
}
