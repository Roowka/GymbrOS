import 'package:flutter/material.dart';

class CalendarEvent {
  final DateTime date;
  final String programName;
  final String sessionName;

  CalendarEvent({
    required this.date,
    required this.programName,
    required this.sessionName,
  });
}

class CalendarProvider with ChangeNotifier {
  final List<CalendarEvent> _events = [];

  List<CalendarEvent> get events => List.unmodifiable(_events);

  void addEvent(CalendarEvent event) {
    final normalizedEvent = CalendarEvent(
      date: DateTime(event.date.year, event.date.month, event.date.day),
      programName: event.programName,
      sessionName: event.sessionName,
    );

    _events.add(normalizedEvent);
    debugPrint(
        'Event added: ${normalizedEvent.sessionName} on ${normalizedEvent.date}');
    notifyListeners();
  }

  List<CalendarEvent> eventsOnDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return _events
        .where((event) => isSameDay(event.date, normalizedDate))
        .toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
