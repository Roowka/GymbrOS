class Program {
  final String name;
  final List<int> sessionIds;
  final DateTime? createdAt;

  Program({
    required this.name,
    required this.sessionIds,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sessionIds': sessionIds,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      name: map['name'],
      sessionIds: List<int>.from(map['sessionIds']),
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }
}
