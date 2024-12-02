class Comment {
  int? id;
  int sessionPlanningId;
  String text;
  String type;

  Comment({
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

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      sessionPlanningId: map['sessionPlanningId'],
      text: map['text'],
      type: map['type'],
    );
  }
}
