class Comment {
  int? id;
  int sessionId;
  String text;
  String type;

  Comment({
    this.id,
    required this.sessionId,
    required this.text,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'text': text,
      'type': type,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      sessionId: map['sessionId'],
      text: map['text'],
      type: map['type'],
    );
  }
}
