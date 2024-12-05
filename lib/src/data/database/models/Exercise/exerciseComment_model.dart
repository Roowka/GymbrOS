class ExerciseComment {
  int? id;
  int sessionPlanningId;
  int exerciseSessionId;
  String exerciseComment;

  ExerciseComment({
    this.id,
    required this.sessionPlanningId,
    required this.exerciseSessionId,
    required this.exerciseComment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionPlanningId,
      'exerciseSessionId': exerciseSessionId,
      'exerciseComment': exerciseComment,
    };
  }

  factory ExerciseComment.fromMap(Map<String, dynamic> map) {
    return ExerciseComment(
      id: map['id'],
      sessionPlanningId: map['sessionId'],
      exerciseSessionId: map['exerciseSessionId'],
      exerciseComment: map['exerciseComment'],
    );
  }
}
