import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exemple d’événements planifiés
    final events = {
      DateTime(2023, 12, 4): ['Séance Pull'],
      DateTime(2023, 12, 6): ['Séance Push'],
      DateTime(2023, 12, 10): ['Séance Leg'],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier des Séances'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2024, 12, 31),
        focusedDay: DateTime.now(),
        eventLoader: (day) => events[day] ?? [],
      ),
    );
  }
}
