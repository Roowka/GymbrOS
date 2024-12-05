import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/providers/session_provider.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:gymbros/src/shared/utils/constants.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  final TextEditingController programNameController = TextEditingController();
  List<int> selectedSessionIds = [];

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final programProvider =
        Provider.of<ProgramProvider>(context, listen: false);
    final sessions = sessionProvider.sessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un Programme'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ pour le nom du programme
            _buildSectionTitle('Nom du Programme'),
            const SizedBox(height: 8),
            TextField(
              controller: programNameController,
              decoration: InputDecoration(
                labelText: 'Ex : Programme Full Body',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sélection des séances
            _buildSectionTitle('Sélectionnez les Séances'),
            const SizedBox(height: 8),
            if (sessions.isEmpty)
              const Text(
                'Aucune séance disponible pour l’instant.',
                style: TextStyle(color: Colors.grey),
              )
            else
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Column(
                  children: sessions.map((session) {
                    final isSelected = selectedSessionIds.contains(session.id);
                    return CheckboxListTile(
                      title: Text(session.name),
                      subtitle: Text('${session.duration} minutes'),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedSessionIds.add(session.id!);
                          } else {
                            selectedSessionIds.remove(session.id);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 20),

            // Bouton de validation
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _validateAndSaveProgram(context, programProvider);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Créer le Programme'),
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
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _validateAndSaveProgram(
      BuildContext context, ProgramProvider programProvider) {
    if (programNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Veuillez entrer un nom pour le programme.')),
      );
      return;
    }

    if (selectedSessionIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner au moins une séance.'),
        ),
      );
      return;
    }

    // Ajouter le programme au Provider
    programProvider.addProgram(
      Program(
        name: programNameController.text,
        sessionIds: selectedSessionIds,
      ),
    );

    // Retour à la page d'accueil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Programme créé avec succès !')),
    );
    Navigator.pushReplacementNamed(context, '/home');
  }
}
