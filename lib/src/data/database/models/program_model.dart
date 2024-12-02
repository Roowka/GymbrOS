class Program {
  int? id;
  int userId;
  String name;
  int duration;

  Program({
    this.id,
    required this.userId,
    required this.name,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'userId': userId, 'name': name, 'duration': duration};
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      duration: map['duration'],
    );
  }
}
