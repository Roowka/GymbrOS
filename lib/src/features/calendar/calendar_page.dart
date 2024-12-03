import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gymbros/src/features/providers/calendar_provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<CalendarProvider>(context);
    final events = calendarProvider.events;

    // Group events by date for quick lookup
    final Map<DateTime, List<CalendarEvent>> eventsByDate = {};
    for (var event in events) {
      final date = DateTime(event.date.year, event.date.month, event.date.day);
      if (!eventsByDate.containsKey(date)) {
        eventsByDate[date] = [];
      }
      eventsByDate[date]!.add(event);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, _) {
                final dayEvents = eventsByDate[day];
                if (dayEvents != null && dayEvents.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
            eventLoader: (day) {
              final normalizedDay =
                  DateTime(day.year, day.month, day.day); // Remove time
              return eventsByDate[normalizedDay] ?? [];
            },
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _selectedDay == null
                ? const Center(child: Text('Sélectionnez une date.'))
                : _buildEventList(
                    eventsByDate[_selectedDay!] ?? [],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(List<CalendarEvent> events) {
    if (events.isEmpty) {
      return const Center(child: Text('Aucun événement pour ce jour.'));
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          leading: const Icon(Icons.event, color: Colors.deepPurple),
          title: Text(event.sessionName),
          subtitle: Text(event.programName),
          trailing: Text(
            '${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}',
          ),
        );
      },
    );
  }
}