import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/data/database/models/Exercise/exerciseSession_model.dart';

class SessionStartedPage extends StatefulWidget {
  final Session session;
  final List<ExerciseSession> exercises;

  const SessionStartedPage({
    super.key,
    required this.session,
    required this.exercises,
  });

  @override
  State<SessionStartedPage> createState() => _SessionStartedPageState();
}

class _SessionStartedPageState extends State<SessionStartedPage> {
  int currentExerciseIndex = 0;
  int currentSet = 1;
  bool isResting = false;
  Timer? restTimer;
  int remainingRestTime = 0;

  void _nextSetOrExercise() {
    final currentExercise = widget.exercises[currentExerciseIndex];

    // Passer à la série suivante
    if (currentSet < currentExercise.sets) {
      setState(() {
        currentSet++;
        isResting = true;
        remainingRestTime = currentExercise.restTime;
      });

      // Démarrer le compte à rebours pour le repos
      _startRestTimer(() {
        setState(() {
          isResting = false;
        });
      });
    }
    // Passer à l'exercice suivant
    else if (currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        currentSet = 1;
        isResting = true;
        remainingRestTime = widget.exercises[currentExerciseIndex].restTime;
      });

      // Démarrer le compte à rebours pour le repos
      _startRestTimer(() {
        setState(() {
          isResting = false;
        });
      });
    }
    // Fin de la séance
    else {
      _finishSession();
    }
  }

  void _startRestTimer(VoidCallback onRestComplete) {
    restTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingRestTime <= 0) {
          timer.cancel();
          onRestComplete();
        } else {
          setState(() {
            remainingRestTime--;
          });
        }
      },
    );
  }

  void _finishSession() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _SessionCompletedPage(
          session: widget.session,
        ),
      ),
    );
  }

  @override
  void dispose() {
    restTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.exercises.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.session.name),
        ),
        body: const Center(
          child: Text(
            "Aucun exercice associé à cette séance.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    final currentExercise = widget.exercises[currentExerciseIndex];
    final isTimeBased = currentExercise.repetitions == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session.name),
      ),
      body: isResting
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Temps de repos",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    "$remainingRestTime secondes restantes",
                    style: const TextStyle(fontSize: 32),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Exercice : ${currentExercise.sessionId}",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Série $currentSet/${currentExercise.sets}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  isTimeBased
                      ? Text(
                          "Durée : ${currentExercise.restTime} secondes",
                          style: const TextStyle(fontSize: 20),
                        )
                      : Text(
                          "Répétitions : ${currentExercise.repetitions}",
                          style: const TextStyle(fontSize: 20),
                        ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _nextSetOrExercise,
                    child: const Text("Fini"),
                  ),
                ],
              ),
            ),
    );
  }
}

class _SessionCompletedPage extends StatelessWidget {
  final Session session;

  const _SessionCompletedPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Séance terminée"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Félicitations !",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Vous avez terminé votre séance.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                labelText: "Ajouter un commentaire",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Retour à l'accueil
              },
              child: const Text("Terminer la séance"),
            ),
          ],
        ),
      ),
    );
  }
}
