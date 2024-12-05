import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/session/page/session_started.dart';
import 'package:gymbros/src/features/session/page/session_page.dart';
import 'package:gymbros/src/features/session/page/session_details_page.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:intl/intl.dart';
import 'package:gymbros/src/shared/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickStartSection(context, sessionProvider),
            const SizedBox(height: 20),
            _buildSessionHistorySection(context, sessionProvider),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStartSection(
      BuildContext context, SessionProvider sessionProvider) {
    final lastSession = sessionProvider.sessions.isNotEmpty
        ? sessionProvider.sessions.first // Séance récente
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Start Strong and Set Your Fitness Goals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SessionPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Créer une nouvelle séance'),
          ),
          const SizedBox(height: 10),
          if (lastSession != null)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionStartedPage(
                      session: lastSession,
                      exercises: sessionProvider
                          .getExercisesForSession(lastSession.id ?? 0),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Lancer la dernière séance'),
            )
          else
            const Text(
              "Aucune séance enregistrée.",
              style: TextStyle(color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildSessionHistorySection(
      BuildContext context, SessionProvider sessionProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Historique des Séances',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        if (sessionProvider.sessions.isEmpty)
          const Text('Aucune séance pour le moment.')
        else
          Column(
            children: sessionProvider.sessions.map((session) {
              String formattedDate =
                  DateFormat('dd MMM yyyy').format(DateTime.now());
              return ListTile(
                title: Text(session.name),
                subtitle: Text('Durée : ${session.duration} Min'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SessionDetailsPage(session: session),
                    ),
                  );
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}
