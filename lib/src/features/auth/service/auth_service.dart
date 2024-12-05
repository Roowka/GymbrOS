import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:gymbros/src/data/database/dao/user_dao.dart';
import 'package:gymbros/src/data/database/models/user_model.dart';

class AuthService {
  Future<String> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return 'All fields are required.';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email address.';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    try {
      final userDao = UserDAO();

      await userDao.insertUser(
        User(name: name, email: email, password: password),
      );

      return 'Signup successful!';
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Both email and password are required.';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email address.';
    }

    try {
      final userDao = UserDAO();
      final users = await userDao.users();

      final hashedPassword = sha256.convert(utf8.encode(password)).toString();

      for (final user in users) {
        if (user.email == email) {
          if (user.password == hashedPassword) {
            return 'Login successful!';
          } else {
            return 'Invalid email or password.';
          }
        }
      }

      return 'Invalid email or password.';
    } catch (e) {
      return 'An error occurred: $e';
    }
  }
}
