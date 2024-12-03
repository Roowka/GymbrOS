import 'package:flutter/material.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/program/page/program_planning_page.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  final TextEditingController programNameController = TextEditingController();
  List<int> selectedSessionIds = [];

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final sessions = sessionProvider.sessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un Programme'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: programNameController,
              decoration: InputDecoration(
                labelText: 'Nom du Programme',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sélectionnez les séances :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...sessions.map((session) {
              final isSelected = selectedSessionIds.contains(session.id);

              return CheckboxListTile(
                title: Text(session.name),
                subtitle: Text('${session.duration} minutes'),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedSessionIds.add(session.id!);
                    } else {
                      selectedSessionIds.remove(session.id);
                    }
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            if (programNameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Veuillez entrer un nom.')),
              );
              return;
            }

            if (selectedSessionIds.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Veuillez sélectionner au moins une séance.')),
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProgramPlanningPage(
                  programName: programNameController.text,
                  sessionIds: selectedSessionIds,
                ),
              ),
            );
          },
          child: const Text('Planifier le Programme'),
        ),
      ),
    );
  }
}
