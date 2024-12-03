import 'package:flutter/material.dart';

class Program {
  final String name;
  final List<int> sessionIds;

  Program({required this.name, required this.sessionIds});
}

class ProgramProvider with ChangeNotifier {
  final List<Program> _programs = [];

  List<Program> get programs => List.unmodifiable(_programs);

  void addProgram(Program program) {
    _programs.add(program);
    notifyListeners(); // Notifie les widgets dépendants
  }
}
