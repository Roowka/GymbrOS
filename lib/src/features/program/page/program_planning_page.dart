import 'package:flutter/material.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:provider/provider.dart';

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
    final sessionProvider = Provider.of<SessionProvider>(context);
    final sessions = widget.sessionIds
        .map((id) => sessionProvider.sessions.firstWhere((s) => s.id == id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Planification : ${widget.programName}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Sélectionnez une date de début :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:
                      DateTime.now(), // Empêche de choisir une date passée
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );

                if (pickedDate != null) {
                  setState(() {
                    startDate = pickedDate;
                  });
                }
              },
              child: Text(
                startDate == null
                    ? 'Choisir une date'
                    : 'Début : ${startDate!.toLocal()}'.split(' ')[0],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Planifiez chaque séance :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...sessions.map((session) {
              return ListTile(
                title: Text(session.name),
                subtitle: sessionSchedule[session.id] == null
                    ? const Text('Aucune date sélectionnée')
                    : Text(
                        'Prévu le ${sessionSchedule[session.id]!.toLocal()}'
                            .split(' ')[0],
                      ),
                trailing: ElevatedButton(
                  onPressed: startDate == null
                      ? null
                      : () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: startDate ?? DateTime.now(),
                            firstDate:
                                startDate!, // Empêche de choisir avant la date de début
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              sessionSchedule[session.id!] = pickedDate;
                            });
                          }
                        },
                  child: const Text('Planifier'),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            if (startDate == null ||
                sessionSchedule.length != sessions.length) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Veuillez sélectionner une date de début et planifier toutes les séances.'),
                ),
              );
              return;
            }

            // Naviguer vers le calendrier après validation
            Navigator.pushNamed(context, '/calendar');
          },
          child: const Text('Valider la Planification'),
        ),
      ),
    );
  }
}
