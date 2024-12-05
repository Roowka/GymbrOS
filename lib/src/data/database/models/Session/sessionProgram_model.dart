class SessionProgram {
  int? id;
  int programId;
  int sessionId;

  SessionProgram({
    this.id,
    required this.programId,
    required this.sessionId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'sessionId': sessionId, 'programId': programId};
  }

  factory SessionProgram.fromMap(Map<String, dynamic> map) {
    return SessionProgram(
      id: map['id'],
      programId: map['programId'],
      sessionId: map['sessionId'],
    );
  }
}
