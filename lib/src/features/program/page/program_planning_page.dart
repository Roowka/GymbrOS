import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/providers/calendar_provider.dart';
import 'package:gymbros/src/shared/utils/constants.dart';

class ProgramPlanningPage extends StatefulWidget {
  final String programName;
  final List<int> sessionIds;

  const ProgramPlanningPage({
    Key? key,
    required this.programName,
    required this.sessionIds,
  }) : super(key: key);

  @override
  _ProgramPlanningPageState createState() => _ProgramPlanningPageState();
}

class _ProgramPlanningPageState extends State<ProgramPlanningPage> {
  DateTime? startDate;
  Map<int, DateTime> sessionSchedule = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planifier : ${widget.programName}'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sélectionnez une date de début :',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      startDate = pickedDate;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  startDate == null
                      ? 'Choisir une date'
                      : 'Début : ${startDate!.toLocal()}'.split(' ')[0],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Planifiez chaque séance :',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
            ),
            const SizedBox(height: 10),
            ...widget.sessionIds.map((sessionId) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Séance $sessionId'),
                  trailing: ElevatedButton(
                    onPressed: startDate == null
                        ? null
                        : () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: startDate ?? DateTime.now(),
                              firstDate: startDate!,
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                sessionSchedule[sessionId] = pickedDate;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Planifier'),
                  ),
                  subtitle: sessionSchedule[sessionId] == null
                      ? const Text('Aucune date sélectionnée',
                          style: TextStyle(color: Colors.grey))
                      : Text(
                          'Prévu le ${sessionSchedule[sessionId]!.toLocal()}'
                              .split(' ')[0],
                          style: const TextStyle(color: Colors.black),
                        ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startDate == null ||
                      sessionSchedule.length != widget.sessionIds.length) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Veuillez planifier toutes les séances avant de valider.'),
                      ),
                    );
                    return;
                  }

                  final calendarProvider =
                      Provider.of<CalendarProvider>(context, listen: false);

                  sessionSchedule.forEach((sessionId, date) {
                    calendarProvider.addEvent(
                      CalendarEvent(
                        date: date,
                        programName: widget.programName,
                        sessionName: 'Séance $sessionId',
                      ),
                    );
                  });

                  Navigator.pushNamed(context, '/home');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Programme planifié avec succès !')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Valider la Planification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
