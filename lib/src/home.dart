import 'package:flutter/material.dart';
import 'package:gymbros/src/shared/utils/constants.dart';
import 'package:gymbros/src/shared/widget/custom_history_title.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/providers/seance_provider.dart';
import 'package:gymbros/src/features/session/page/session_page.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de création de séance
            Container(
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
                    child: const Text('Start Exercise'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Section historique des séances
            Text(
              'Workout History',
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
                  return CustomHistoryTitle(
                    workoutDate: formattedDate,
                    workoutType: session.name,
                    workoutDuration: '${session.duration} Min',
                  );
                }).toList(),
              ),
            const SizedBox(height: 30),

            // Section historique des programmes
            Text(
              'Program History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            if (sessionProvider.sessions.isEmpty)
              const Text('Aucun programme pour le moment.')
            else
              Column(
                children: sessionProvider.sessions.map((session) {
                  String formattedDate =
                      DateFormat('dd MMM yyyy').format(DateTime.now());
                  return CustomHistoryTitle(
                    workoutDate: formattedDate,
                    workoutType: session.name,
                    workoutDuration: 'Program Details',
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
