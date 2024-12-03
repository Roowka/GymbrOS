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
    _events.add(event);
    notifyListeners();
  }

  List<CalendarEvent> eventsOnDate(DateTime date) {
    return _events.where((event) => isSameDay(event.date, date)).toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
