import 'package:flutter/material.dart';
import 'home.dart';
import 'features/auth/page/login_page.dart';
import 'features/auth/page/signup_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymbrOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // Login Page
        '/signup': (context) => SignUpPage(), // Sign Up Page
        '/home': (context) =>
            const MyHomePage(title: 'GymbrOS App'), // Home Page
      },
    );
  }
}
