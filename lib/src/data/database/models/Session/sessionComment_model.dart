class SessionComment {
  int? id;
  int sessionPlanningId;
  String text;
  String type;

  SessionComment({
    this.id,
    required this.sessionPlanningId,
    required this.text,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionPlanningId,
      'text': text,
      'type': type,
    };
  }

  factory SessionComment.fromMap(Map<String, dynamic> map) {
    return SessionComment(
      id: map['id'],
      sessionPlanningId: map['sessionPlanningId'],
      text: map['text'],
      type: map['type'],
    );
  }
}
