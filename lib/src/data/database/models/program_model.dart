import 'dart:convert';

class Program {
  final int? id; // Ajout de l'identifiant
  final String name;
  final List<int> sessionIds;
  final DateTime? createdAt;

  Program({
    this.id, // Champ facultatif
    required this.name,
    required this.sessionIds,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Inclure l'id dans la map
      'name': name,
      'sessionIds': jsonEncode(sessionIds), // Conversion en JSON
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      id: map['id'], // Extraire l'id
      name: map['name'],
      sessionIds: List<int>.from(
          jsonDecode(map['sessionIds'])), // Conversion JSON vers List<int>
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }
}
