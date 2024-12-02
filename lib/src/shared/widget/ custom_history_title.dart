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
      title: Text(workoutType),
      subtitle: Text(workoutDate),
      trailing: Text(workoutDuration),
    );
  }
}
