import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/program_model.dart';

class ProgramProvider with ChangeNotifier {
  List<Program> _programs = [];

  List<Program> get programs => _programs;

  void addProgram(Program program) {
    _programs.insert(0, program);
    notifyListeners();
  }
}
