class Exercise {
  int? id;
  String name;
  int repetitions;
  int sets;
  int difficulty;

  Exercise({
    this.id,
    required this.name,
    required this.repetitions,
    required this.sets,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'repetitions': repetitions,
      'sets': sets,
      'difficulty': difficulty,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      repetitions: map['repetitions'],
      sets: map['sets'],
      difficulty: map['difficulty'],
    );
  }
}
