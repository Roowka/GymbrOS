enum SessionType {
  amrap,
  hiit,
  emom,
}

class Session {
  int? id;
  String name;
  SessionType type;
  int duration;

  Session({
    this.id,
    required this.name,
    required this.type,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last,
      'duration': duration,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      name: map['name'],
      type: SessionType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
      ),
      duration: map['duration'],
    );
  }
}
