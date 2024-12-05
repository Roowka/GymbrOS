import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/features/program/page/program_planning_page.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:gymbros/src/shared/utils/constants.dart';
import 'package:provider/provider.dart';

class ProgramDetailsPage extends StatelessWidget {
  final Program program;

  const ProgramDetailsPage({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final sessions = sessionProvider.sessions;

    return Scaffold(
      appBar: AppBar(
        title: Text('${program.name}'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Séances incluses :',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 10),

            // Affichage des séances incluses
            ...program.sessionIds.map((sessionId) {
              final session = sessions.firstWhere(
                (s) => s.id == sessionId,
                orElse: () => Session(
                  id: sessionId,
                  name: 'Séance inconnue',
                  type: SessionType.amrap,
                  duration: 0,
                ),
              );

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(
                    Icons.fitness_center,
                    color: AppColors.secondaryColor,
                  ),
                  title: Text(
                    session.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Durée : ${session.duration} min'),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),

            // Bouton pour planifier le programme
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgramPlanningPage(
                        programName: program.name,
                        sessionIds: program.sessionIds,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Planifier le Programme'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
