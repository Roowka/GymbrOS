import '../models/comment_model.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class CommentDao {
  Future<int> insertComment(Comment comment) async {
    print('Inserting comment...');
    final db = await DBHelper.openDB();
    return await db.insert(
      'comment',
      Comment(
              sessionId: comment.sessionId,
              text: comment.text,
              type: comment.type)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Comment>> Comments() async {
    print('Fetching comments...');
    final db = await DBHelper.openDB();

    final List<Map<String, Object?>> commentMaps = await db.query('comment');

    return [
      for (final {
            'id': id as int,
            'sessionId': sessionId as int,
            'text': text as String,
            'type': type as String
          } in commentMaps)
        Comment(
          id: id,
          sessionId: sessionId,
          text: text,
          type: type,
        )
    ];
  }

  Future<void> updateComment(Comment comment) async {
    print('Updating comment...');
    final db = await DBHelper.openDB();

    await db.update(
      'comment',
      comment.toMap(),
      where: 'id = ?',
      whereArgs: [comment.id],
    );
  }

  Future<void> deleteComment(int id) async {
    print('Deleting comment...');
    final db = await DBHelper.openDB();

    await db.delete(
      'comment',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllComments() async {
    print('Deleting all comments...');
    final db = await DBHelper.openDB();

    await db.delete(
      'comment',
    );
  }
}
