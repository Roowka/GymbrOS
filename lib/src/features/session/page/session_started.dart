import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/data/database/models/Exercise/exerciseSession_model.dart';
import 'package:gymbros/src/shared/utils/constants.dart';

class SessionStartedPage extends StatefulWidget {
  final Session session;
  final List<ExerciseSession> exercises;

  const SessionStartedPage({
    Key? key,
    required this.session,
    required this.exercises,
  }) : super(key: key);

  @override
  _SessionStartedPageState createState() => _SessionStartedPageState();
}

class _SessionStartedPageState extends State<SessionStartedPage> {
  late List<ExerciseSession> exerciseList;
  int currentExerciseIndex = 0;
  int currentSet = 1;
  bool isResting = false;
  int restTimeRemaining = 0; // Temps de repos restant
  Timer? restTimer; // Timer pour gérer le compte à rebours

  @override
  void initState() {
    super.initState();

    // Vérification si la liste d'exercices est vide
    exerciseList = widget.exercises.isNotEmpty
        ? widget.exercises
        : _generateDefaultExercises(); // Générer des exercices par défaut si la liste est vide
  }

  @override
  void dispose() {
    restTimer?.cancel(); // Annuler le timer si la page est détruite
    super.dispose();
  }

  // Génère des exercices par défaut pour tester la page
  List<ExerciseSession> _generateDefaultExercises() {
    return [
      ExerciseSession(
        id: 1,
        sessionId: widget.session.id!,
        exerciseId: 1,
        sets: 3,
        repetitions: 10,
        duration: 0,
        restTime: 15,
      ),
      ExerciseSession(
        id: 2,
        sessionId: widget.session.id!,
        exerciseId: 2,
        sets: 2,
        repetitions: 8,
        duration: 0,
        restTime: 10,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = exerciseList[currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session.name),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isResting) ...[
              Text(
                'Exercice : ${currentExercise.exerciseId}', // Remplacez par le nom réel de l'exercice
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Série : $currentSet/${currentExercise.sets}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                currentExercise.repetitions > 0
                    ? 'Répétitions : ${currentExercise.repetitions}'
                    : 'Durée : ${currentExercise.duration} secondes',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _handleExerciseComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Fini'),
              ),
            ] else ...[
              Text(
                'Repos...',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$restTimeRemaining secondes',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Gestion de la fin d'un exercice ou d'une série
  void _handleExerciseComplete() {
    final currentExercise = exerciseList[currentExerciseIndex];

    if (currentSet < currentExercise.sets) {
      setState(() {
        isResting = true;
        restTimeRemaining = currentExercise.restTime;
      });
      _startRestTimer();
    } else if (currentExerciseIndex < exerciseList.length - 1) {
      setState(() {
        currentSet = 1;
        currentExerciseIndex++;
        isResting = false;
      });
    } else {
      _finishSession();
    }
  }

  // Démarre un compte à rebours pour le temps de repos
  void _startRestTimer() {
    restTimer?.cancel(); // Annuler tout timer existant
    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (restTimeRemaining > 0) {
          restTimeRemaining--;
        } else {
          timer.cancel();
          isResting = false;
          currentSet++;
        }
      });
    });
  }

  // Affiche un message de fin de séance
  void _finishSession() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Séance Terminée !'),
          content: const Text(
            'Bravo pour avoir terminé votre séance !',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        );
      },
    );
  }
}
