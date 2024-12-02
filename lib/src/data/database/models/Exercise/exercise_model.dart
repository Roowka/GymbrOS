class Exercise {
  int? id;
  String name;
  int difficulty;

  Exercise({
    this.id,
    required this.name,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'difficulty': difficulty};
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      difficulty: map['difficulty'],
    );
  }
}
