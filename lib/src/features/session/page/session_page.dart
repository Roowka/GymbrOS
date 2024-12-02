import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/shared/utils/constants.dart';
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

  // Champ pour le nom de la séance
  final TextEditingController sessionNameController = TextEditingController();

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
        title: const Text('Configurer une Séance'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ pour le nom de la séance
            _buildSectionTitle('Nom de la Séance'),
            const SizedBox(height: 8),
            TextField(
              controller: sessionNameController,
              decoration: InputDecoration(
                labelText: 'Ex : Séance Full Body',
                labelStyle: TextStyle(color: AppColors.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Choix des exercices
            _buildSectionTitle('Choix des Exercices'),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ExpansionTile(
                title: const Text('Exercices Disponibles'),
                textColor: AppColors.primaryColor,
                iconColor: AppColors.primaryColor,
                children: availableExercises.map((exercise) {
                  return CheckboxListTile(
                    activeColor: AppColors.primaryColor,
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
            ),
            const SizedBox(height: 20),

            // Type de séance
            _buildSectionTitle('Type de Séance'),
            const SizedBox(height: 8),
            DropdownButtonFormField<SessionType>(
              value: selectedSessionType,
              hint: const Text('Sélectionnez un type'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
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
            const SizedBox(height: 20),

            // Paramètres des exercices
            if (selectedExercises.isNotEmpty) ...[
              _buildSectionTitle('Paramètres des Exercices'),
              const SizedBox(height: 8),
              ...selectedExercises.map((exercise) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: ExpansionTile(
                    title: Text('Paramètres pour $exercise'),
                    textColor: AppColors.primaryColor,
                    iconColor: AppColors.primaryColor,
                    children: [
                      _buildExerciseParameter(
                        context,
                        'Durée (minutes) ou Répétitions',
                        'Ex : 10',
                        (value) {
                          setState(() {
                            exerciseParams[exercise]['repetitions'] =
                                int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                      _buildExerciseParameter(
                        context,
                        'Séries',
                        'Ex : 3',
                        (value) {
                          setState(() {
                            exerciseParams[exercise]['series'] =
                                int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                      _buildExerciseParameter(
                        context,
                        'Temps de Repos (secondes)',
                        'Ex : 30',
                        (value) {
                          setState(() {
                            exerciseParams[exercise]['rest'] =
                                int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
            const SizedBox(height: 20),

            // Bouton de validation
            Center(
              child: ElevatedButton(
                onPressed: _validateAndSaveSession,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Valider la Séance'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildExerciseParameter(
    BuildContext context,
    String label,
    String hint,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.primaryColor),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  void _validateAndSaveSession() {
    if (sessionNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un nom pour la séance'),
        ),
      );
      return;
    }

    if (selectedExercises.isEmpty || selectedSessionType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Veuillez sélectionner des exercices et un type de séance'),
        ),
      );
      return;
    }

    int totalDuration = _calculateTotalDuration();

    Session newSession = Session(
      name: sessionNameController.text,
      duration: totalDuration,
      type: selectedSessionType!,
    );

    Provider.of<SessionProvider>(context, listen: false).addSession(newSession);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Séance sauvegardée avec succès')),
    );

    Navigator.pushReplacementNamed(context, '/home');
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
