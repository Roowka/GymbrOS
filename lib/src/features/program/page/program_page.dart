import 'package:flutter/material.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  // Liste des exercices disponibles
  final List<String> availableExercises = [
    'Pompes',
    'Squats',
    'Burpees',
    'Planches',
    // Ajoutez d'autres exercices ici
  ];

  // Exercices sélectionnés
  List<String> selectedExercises = [];

  // Type de séance
  String? selectedSessionType;

  // Types de séances disponibles
  final List<String> sessionTypes = [
    'AMRAP',
    'HIIT',
    'EMOM',
  ];

  // Paramètres pour chaque exercice
  Map<String, dynamic> exerciseParams = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurer une séance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Choix des exercices
            ExpansionTile(
              title: Text('Choix des exercices'),
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
              title: Text('Type de séance'),
              trailing: DropdownButton<String>(
                value: selectedSessionType,
                hint: Text('Sélectionnez un type'),
                items: sessionTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
                    title: Text('Durée (en minutes) ou Répétitions'),
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
                        decoration: InputDecoration(
                          hintText: 'Ex: 10 répétitions',
                        ),
                      ),
                    ),
                  ),
                  // Nombre de séries
                  ListTile(
                    title: Text('Séries'),
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
                        decoration: InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                  ),
                  // Temps de repos
                  ListTile(
                    title: Text('Temps de repos (secondes)'),
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
                        decoration: InputDecoration(
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
                // Traitement des données saisies
                print('Exercices sélectionnés: $selectedExercises');
                print('Type de séance: $selectedSessionType');
                print('Paramètres des exercices: $exerciseParams');
                // Vous pouvez maintenant sauvegarder ou planifier la séance
              },
              child: Text('Valider la séance'),
            ),
          ],
        ),
      ),
    );
  }
}
