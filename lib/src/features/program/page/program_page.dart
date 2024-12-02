import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/Session/session_model.dart';
import 'package:gymbros/src/features/providers/program_provider.dart';
import 'package:gymbros/src/features/providers/seance_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  final _formKey = GlobalKey<FormState>();

  // Champs du formulaire
  String programName = '';
  List<Session> selectedSessions = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isRepeating = false;
  List<String> repeatDays = [];

  @override
  Widget build(BuildContext context) {
    final sessions = Provider.of<SessionProvider>(context).sessions;

    return Scaffold(
      appBar: AppBar(title: const Text('Planifier le programme')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nom du programme
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom du programme',
                  hintText: 'Ex : programme PPL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom pour le programme.';
                  }
                  return null;
                },
                onSaved: (value) {
                  programName = value!;
                },
              ),
              const SizedBox(height: 20),

              Text(
                'Sélectionnez une ou plusieurs séances',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              sessions.isEmpty
                  ? const Text('Aucune séance disponible.')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        final isSelected = selectedSessions.contains(session);

                        return CheckboxListTile(
                          title: Text(session.name),
                          subtitle: Text(
                              '${session.duration} minutes - ${session.type.toString().split('.').last}'),
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedSessions.add(session);
                              } else {
                                selectedSessions.remove(session);
                              }
                            });
                          },
                        );
                      },
                    ),
              const SizedBox(height: 20),

              // Sélection de la date
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(selectedDate == null
                    ? 'Choisissez une date'
                    : DateFormat('dd/MM/yyyy').format(selectedDate!)),
                trailing: ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('Sélectionner'),
                ),
              ),
              const SizedBox(height: 20),

              // Sélection de l'heure
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(selectedTime == null
                    ? 'Choisissez une heure'
                    : selectedTime!.format(context)),
                trailing: ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  child: const Text('Sélectionner'),
                ),
              ),
              const SizedBox(height: 20),

              // Répétition
              SwitchListTile(
                title: const Text('Répéter ce programme'),
                value: isRepeating,
                onChanged: (bool value) {
                  setState(() {
                    isRepeating = value;
                  });
                },
              ),
              if (isRepeating)
                Wrap(
                  spacing: 10,
                  children: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim']
                      .map(
                        (day) => FilterChip(
                          label: Text(day),
                          selected: repeatDays.contains(day),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                repeatDays.add(day);
                              } else {
                                repeatDays.remove(day);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),

              const SizedBox(height: 30),

              // Bouton de validation
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _saveProgram();
                    }
                  },
                  child: const Text('Planifier le programme'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProgram() {
    // Vérifier si tous les champs obligatoires sont remplis
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une date et une heure.'),
        ),
      );
      return;
    }

    if (selectedSessions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner au moins une séance.'),
        ),
      );
      return;
    }

    final sessionNames =
        selectedSessions.map((session) => session.name).join(', ');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Programme "$programName" basé sur les séances "$sessionNames" planifié pour le ${DateFormat('dd/MM/yyyy').format(selectedDate!)} à ${selectedTime!.format(context)}.',
        ),
      ),
    );

    // Retour à la page d'accueil
    Navigator.pushReplacementNamed(context, '/home');
  }
}
