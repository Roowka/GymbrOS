import 'package:gymbros/src/data/database/models/exercice_model.dart';

class Program {
  int? id;
  String name;
  int duration;
  List<Exercise> exercises;

  Program({
    this.id,
    required this.name,
    required this.duration,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      id: map['id'],
      name: map['name'],
      duration: map['duration'],
      exercises: List<Exercise>.from(
        map['exercises']?.map((x) => Exercise.fromMap(x)) ?? [],
      ),
    );
  }
}
