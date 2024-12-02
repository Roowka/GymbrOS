import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';

class SessionDetailsPage extends StatelessWidget {
  final Session session;

  const SessionDetailsPage({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Séance - ${session.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom de la Séance :',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              session.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Type de Séance :',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              session.type.toString().split('.').last.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Durée Totale :',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '${session.duration} minutes',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
