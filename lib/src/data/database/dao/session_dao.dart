import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';
import '../models/session_model.dart';

class SessionDAO {
  Future<int> insertSession(Session session) async {
    print('Inserting session...');
    final db = await DBHelper.openDB();
    return await db.insert(
      'session',
      Session(
              name: session.name,
              date: session.date,
              duration: session.duration,
              userId: session.userId,
              programId: session.programId)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Session>> Sessions() async {
    print('Fetching sessions...');
    final db = await DBHelper.openDB();

    final List<Map<String, Object?>> sessionMaps = await db.query('session');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'date': date as String,
            'duration': duration as int,
            'userId': userId as int,
            'programId': programId as int,
          } in sessionMaps)
        Session(
            id: id,
            name: name,
            date: date,
            duration: duration,
            userId: userId,
            programId: programId),
    ];
  }

  Future<void> updateSession(Session session) async {
    print('Updating session...');
    final db = await DBHelper.openDB();

    await db.update(
      'session',
      session.toMap(),
      where: 'id = ?',
      whereArgs: [session.id],
    );
  }

  Future<void> deleteSession(int id) async {
    print('Deleting session...');
    final db = await DBHelper.openDB();

    await db.delete(
      'session',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllSessions() async {
    print('Deleting all sessions...');
    final db = await DBHelper.openDB();

    await db.delete(
      'session',
    );
  }
}
