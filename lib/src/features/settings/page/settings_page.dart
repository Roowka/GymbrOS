import 'package:flutter/material.dart';
import 'package:gymbros/src/data/database/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:gymbros/src/features/providers/user_provider.dart';
import 'package:gymbros/src/shared/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final user = userProvider.user;
    print("SETTINGS : ${user}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Profil utilisateur",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (user != null) ...[
              ListTile(
                leading:
                    const Icon(Icons.person, color: AppColors.primaryColor),
                title: Text(
                  user.name,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: const Text("Nom"),
              ),
              ListTile(
                leading: const Icon(Icons.email, color: AppColors.primaryColor),
                title: Text(
                  user.email,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: const Text("Email"),
              ),
            ] else ...[
              const Text(
                "Chargement des informations utilisateur...",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Réinitialiser l'état utilisateur et rediriger
                  await userProvider.logoutUser();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false, // Supprimer toutes les routes précédentes
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text("Se déconnecter"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
