import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';

class SessionProvider with ChangeNotifier {
  List<Session> _sessions = [];

  List<Session> get sessions => _sessions;

  void addSession(Session session) {
    _sessions.insert(0, session);
    notifyListeners();
  }
}
