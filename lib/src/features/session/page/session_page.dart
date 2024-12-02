import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final List<String> availableExercises = [
    'Pompes',
    'Squats',
    'Burpees',
    'Planches',
  ];

  List<String> selectedExercises = [];

  // Type de séance
  SessionType? selectedSessionType;

  // Types de séances disponibles
  final List<SessionType> sessionTypes = [
    SessionType.amrap,
    SessionType.hiit,
    SessionType.emom,
  ];

  // Paramètres pour chaque exercice
  Map<String, dynamic> exerciseParams = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurer une seance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Choix des exercices
            ExpansionTile(
              title: const Text('Choix des exercices'),
              children: availableExercises.map((exercise) {
                return CheckboxListTile(
                  title: Text(exercise),
                  value: selectedExercises.contains(exercise),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedExercises.add(exercise);
                        exerciseParams[exercise] = {
                          'repetitions': 0,
                          'series': 0,
                          'rest': 0,
                        };
                      } else {
                        selectedExercises.remove(exercise);
                        exerciseParams.remove(exercise);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            // Type de séance
            ListTile(
              title: const Text('Type de séance'),
              trailing: DropdownButton<SessionType>(
                value: selectedSessionType,
                hint: const Text('Sélectionnez un type'),
                items: sessionTypes.map((SessionType type) {
                  return DropdownMenuItem<SessionType>(
                    value: type,
                    child: Text(type.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (SessionType? newValue) {
                  setState(() {
                    selectedSessionType = newValue;
                  });
                },
              ),
            ),
            // Paramètres des exercices
            ...selectedExercises.map((exercise) {
              return ExpansionTile(
                title: Text('Paramètres pour $exercise'),
                children: [
                  // Durée ou répétitions
                  ListTile(
                    title: const Text('Durée (en minutes) ou Répétitions'),
                    trailing: SizedBox(
                      width: 150,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            exerciseParams[exercise]['repetitions'] =
                                int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Ex: 10 répétitions',
                        ),
                      ),
                    ),
                  ),
                  // Nombre de séries
                  ListTile(
                    title: const Text('Séries'),
                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            exerciseParams[exercise]['series'] =
                                int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                  ),
                  // Temps de repos
                  ListTile(
                    title: const Text('Temps de repos (secondes)'),
                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            exerciseParams[exercise]['rest'] =
                                int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
            // Bouton de validation
            ElevatedButton(
              onPressed: () {
                if (selectedExercises.isEmpty || selectedSessionType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Veuillez sélectionner des exercices et un type de séance'),
                    ),
                  );
                  return;
                }

                // Calculer la durée totale de la séance
                int totalDuration = _calculateTotalDuration();

                // Création de l'instance de Session avec les données saisies
                Session newSession = Session(
                  name:
                      'Séance ${selectedSessionType.toString().split('.').last.toUpperCase()}',
                  duration: totalDuration,
                  type: selectedSessionType!,
                );

                Provider.of<SessionProvider>(context, listen: false)
                    .addSession(newSession);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Séance sauvegardée avec succès')),
                );

                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Valider la seance'),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTotalDuration() {
    int totalDuration = 0;

    for (var exercise in selectedExercises) {
      int repetitions = exerciseParams[exercise]['repetitions'];
      int series = exerciseParams[exercise]['series'];
      int rest = exerciseParams[exercise]['rest'];

      int exerciseDuration =
          (repetitions * series) + ((series - 1) * rest ~/ 60);
      totalDuration += exerciseDuration;
    }

    return totalDuration;
  }
}
