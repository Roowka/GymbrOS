import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> openDB() async {
    log('Creating database...');
    final database = openDatabase(
      join(await getDatabasesPath(), 'gymbros_db.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE Session (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            date TEXT NOT NULL,
            duration INTEGER NOT NULL,
            userId INTEGER NOT NULL,
            programId INTEGER NOT NULL,
            FOREIGN KEY(userId) REFERENCES User(id),
            FOREIGN KEY(programId) REFERENCES Program(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE Program (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            duration INTEGER NOT NULL,
            exercises TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE Exercise (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            repetitions INTEGER NOT NULL,
            sets INTEGER NOT NULL,
            difficulty INTEGER NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE Comment (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sessionId INTEGER NOT NULL,
            text TEXT NOT NULL,
            type TEXT NOT NULL,
            FOREIGN KEY(sessionId) REFERENCES Session(id)
          )
        ''');
      },
      version: 1,
    );
    log('Database created !');
    return database;
  }

  static Future<void> closeDB(Database db) async {
    await db.close();
  }
}
