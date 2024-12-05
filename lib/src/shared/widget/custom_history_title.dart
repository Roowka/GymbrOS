import 'package:flutter/material.dart';

class CustomHistoryTitle extends StatelessWidget {
  final String workoutDate;
  final String workoutType;
  final String workoutDuration;
  final VoidCallback? onTap; // Nouveau paramètre pour personnaliser le clic

  const CustomHistoryTitle({
    Key? key,
    required this.workoutDate,
    required this.workoutType,
    required this.workoutDuration,
    this.onTap, // Ajout du paramètre onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const Icon(Icons.fitness_center), // Icône, ajustable selon besoin
      title: Text(workoutType),
      subtitle: Text('$workoutDate - $workoutDuration'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap, // Utilise le onTap passé par le constructeur
    );
  }
}
