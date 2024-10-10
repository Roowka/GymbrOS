import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';
import '../models/user_model.dart';

class UserDAO {
  // Méthode pour insérer un nouvel utilisateur dans la base de données
  Future<int> insertUser() async {
    final db = await DBHelper.openDB();
    return await db.insert(
      'User', // Nom de la table
      User(name: 'Lucas', email: 'lucas@lu.com')
          .toMap(), // Données de l'utilisateur
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Remplace en cas de doublon
    );
  }
}
