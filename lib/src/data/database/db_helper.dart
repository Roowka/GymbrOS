import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> openDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'gymbros_db.db'),
      onCreate: (db, version) async {
        await db.execute('''
          DROP TABLE IF EXISTS Exercise;
          DROP TABLE IF EXISTS ExerciseComment;
          DROP TABLE IF EXISTS ExerciseSession;
          DROP TABLE IF EXISTS Session;
          DROP TABLE IF EXISTS SessionComment;
          DROP TABLE IF EXISTS SessionPlanning;
          DROP TABLE IF EXISTS SessionProgram;
          DROP TABLE IF EXISTS User;
          DROP TABLE IF EXISTS Program;
        ''');

        await db.execute('''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE Exercise (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            difficulty INTEGER NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE ExerciseComment (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sessionPlanningId INTEGER NOT NULL,
            exerciseSessionId INTEGER NOT NULL,
            exerciseComment TEXT NOT NULL,
            FOREIGN KEY (sessionPlanningId) REFERENCES SessionPlanning (id),
            FOREIGN KEY (exerciseSessionId) REFERENCES ExerciseSession (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE ExerciseSession (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sessionId INTEGER NOT NULL,
            exerciseId INTEGER NOT NULL,
            sets INTEGER NOT NULL,
            repetitions INTEGER NOT NULL,
            duration INTEGER NOT NULL,
            restTime INTEGER NOT NULL,
            FOREIGN KEY (sessionId) REFERENCES Session (id),
            FOREIGN KEY (exerciseId) REFERENCES Exercise (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE Session (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            type TEXT NOT NULL,
            duration INTEGER NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE SessionComment (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sessionPlanningId INTEGER NOT NULL,
            text TEXT NOT NULL,
            type TEXT NOT NULL,
            FOREIGN KEY (sessionPlanningId) REFERENCES SessionPlanning (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE SessionPlanning (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sessionId INTEGER NOT NULL,
            date TEXT NOT NULL,
            sessionComment TEXT NOT NULL,
            userId INTEGER NOT NULL,
            FOREIGN KEY (sessionId) REFERENCES Session (id),
            FOREIGN KEY (userId) REFERENCES User (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE SessionProgram (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            programId INTEGER NOT NULL,
            sessionId INTEGER NOT NULL,
            FOREIGN KEY (programId) REFERENCES Program (id),
            FOREIGN KEY (sessionId) REFERENCES Session (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE Program (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            name TEXT NOT NULL,
            duration INTEGER NOT NULL,
            FOREIGN KEY (userId) REFERENCES User (id)
          )
        ''');

        await db.execute('CREATE INDEX idx_user_email ON User(email);');
        await db.execute('CREATE INDEX idx_exercise_name ON Exercise(name);');
        await db.execute(
            'CREATE INDEX idx_exercise_comment_sessionId ON ExerciseComment(sessionPlanningId);');
        await db.execute(
            'CREATE INDEX idx_exercise_session_sessionId ON ExerciseSession(sessionId);');
        await db.execute('CREATE INDEX idx_session_name ON Session(name);');
        await db.execute(
            'CREATE INDEX idx_session_comment_planningId ON SessionComment(sessionPlanningId);');
        await db.execute(
            'CREATE INDEX idx_session_planning_date ON SessionPlanning(date);');
        await db.execute(
            'CREATE INDEX idx_session_program_programId ON SessionProgram(programId);');
        await db.execute('CREATE INDEX idx_program_userId ON Program(userId);');
      },
      version: 1,
    );
    return database;
  }

  static Future<void> closeDB(Database db) async {
    await db.close();
  }
}
