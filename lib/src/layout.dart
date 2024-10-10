import 'package:flutter/material.dart';
import 'package:gymbros/src/features/auth/page/login_page.dart';
import 'package:gymbros/src/features/auth/page/signup_page.dart';
import 'package:gymbros/src/home.dart';

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
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const MyHomePage(title: 'GymbrOS App'),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text('Page Not Found')),
                ));
      },
    );
  }
}
