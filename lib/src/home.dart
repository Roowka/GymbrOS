import 'package:flutter/material.dart';
import 'package:gymbros/src/features/program/page/program_details_page.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:gymbros/src/features/providers/calendar_provider.dart';
import 'package:gymbros/src/features/providers/user_provider.dart';
import 'package:gymbros/src/shared/utils/constants.dart';
import 'package:gymbros/src/shared/widget/custom_history_title.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/session/page/session_page.dart';
import 'package:gymbros/src/features/session/page/session_details_page.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);
    final sessionProvider = Provider.of<SessionProvider>(context);
    final calendarProvider = Provider.of<CalendarProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

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
            _buildStartExerciseSection(context),
            const SizedBox(height: 20),
            _buildSessionHistorySection(context, sessionProvider),
            const SizedBox(height: 30),
            _buildProgramHistorySection(context, programProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildStartExerciseSection(BuildContext context) {
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
            child: const Text('Start Exercise'),
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
              return CustomHistoryTitle(
                workoutDate: formattedDate,
                workoutType: session.name,
                workoutDuration: '${session.duration} Min',
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

  Widget _buildProgramHistorySection(
      BuildContext context, ProgramProvider programProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Historique des Programmes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        if (programProvider.programs.isEmpty)
          const Text('Aucun programme pour le moment.')
        else
          Column(
            children: programProvider.programs.map((program) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                title: Text(program.name),
                subtitle: const Text('Programme existant'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProgramDetailsPage(program: program),
                      ),
                    );
                  },
                  child: const Text('Détail du Programme'),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  // Widget : Section Démarrage rapide
  Widget _buildQuickStartSection(BuildContext context) {
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
            child: const Text('Start Exercise'),
          ),
        ],
      ),
    );
  }

  // Widget : Titre de section
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget : Historique des séances
  Widget _buildSessionHistory(
      BuildContext context, SessionProvider sessionProvider) {
    if (sessionProvider.sessions.isEmpty) {
      return const Text('Aucune séance pour le moment.');
    } else {
      return Column(
        children: sessionProvider.sessions.map((session) {
          String formattedDate =
              DateFormat('dd MMM yyyy').format(DateTime.now());
          return CustomHistoryTitle(
            workoutDate: formattedDate,
            workoutType: session.name,
            workoutDuration: '${session.duration} Min',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionDetailsPage(session: session),
                ),
              );
            },
          );
        }).toList(),
      );
    }
  }

  // Widget : Historique des programmes
  Widget _buildProgramHistory(
      BuildContext context, ProgramProvider programProvider) {
    if (programProvider.programs.isEmpty) {
      return const Text('Aucun programme pour le moment.');
    } else {
      return Column(
        children: programProvider.programs.map((program) {
          String formattedDate =
              DateFormat('dd MMM yyyy').format(DateTime.now());
          return CustomHistoryTitle(
            workoutDate: formattedDate,
            workoutType: program.name,
            workoutDuration: 'Program Details',
          );
        }).toList(),
      );
    }
  }
}
