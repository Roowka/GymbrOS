class Session {
  int? id;
  String name;
  String date;
  int duration;
  int userId;
  int programId;

  Session({
    this.id,
    required this.name,
    required this.date,
    required this.duration,
    required this.userId,
    required this.programId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'duration': duration,
      'userId': userId,
      'programId': programId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      duration: map['duration'],
      userId: map['userId'],
      programId: map['programId'],
    );
  }
}
