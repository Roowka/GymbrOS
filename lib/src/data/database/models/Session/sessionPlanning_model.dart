class SessionPlanning {
  int? id;
  int sessionId;
  DateTime date;
  String sessionComment;
  int userId;

  SessionPlanning({
    this.id,
    required this.sessionId,
    required this.date,
    required this.sessionComment,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'date': date.toIso8601String(),
      'sessionComment': sessionComment,
      'userId': userId
    };
  }

  factory SessionPlanning.fromMap(Map<String, dynamic> map) {
    return SessionPlanning(
      id: map['id'],
      sessionId: map['sessionId'],
      date: DateTime.parse(map['date']),
      sessionComment: map['sessionComment'],
      userId: map['userId'],
    );
  }
}
