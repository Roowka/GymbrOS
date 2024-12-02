import 'package:flutter/material.dart';

class CustomHistoryTitle extends StatelessWidget {
  final String workoutDate;
  final String workoutType;
  final String workoutDuration;

  const CustomHistoryTitle({
    Key? key,
    required this.workoutDate,
    required this.workoutType,
    required this.workoutDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.fitness_center), // Example icon, adjust as necessary
      title: Text(workoutType),
      subtitle: Text('$workoutDate - $workoutDuration'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Handle onTap for more details or actions
      },
    );
  }
}
