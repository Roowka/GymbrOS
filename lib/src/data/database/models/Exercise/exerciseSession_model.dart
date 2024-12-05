class ExerciseSession {
  int? id;
  int sessionId;
  int exerciseId;
  int sets;
  int repetitions;
  int duration;
  int restTime;

  ExerciseSession({
    this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.sets,
    required this.repetitions,
    required this.duration,
    required this.restTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'sets': sets,
      'repetitions': repetitions,
      'duration': duration,
      'restTime': restTime,
    };
  }

  factory ExerciseSession.fromMap(Map<String, dynamic> map) {
    return ExerciseSession(
      id: map['id'],
      sessionId: map['sessionId'],
      exerciseId: map['exerciseId'],
      sets: map['sets'],
      repetitions: map['repetitions'],
      duration: map['duration'],
      restTime: map['restTime'],
    );
  }
}
