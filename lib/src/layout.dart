import 'package:flutter/material.dart';
import 'package:gymbros/src/features/auth/page/login_page.dart';
import 'package:gymbros/src/features/auth/page/signup_page.dart';
import 'package:gymbros/src/home.dart';
import 'package:gymbros/src/features/session/page/session_page.dart';
import 'package:gymbros/src/features/program/page/program_page.dart';
import 'package:gymbros/src/features/settings/page/settings_page.dart';
import 'package:gymbros/src/features/calendar/calendar_page.dart'; // Import de la page calendrier

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
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const MainNavigation(),
        '/calendar': (context) => const CalendarPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page Not Found')),
          ),
        );
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List of widgets for each tab
  static const List<Widget> _pages = <Widget>[
    MyHomePage(title: 'GymbrOS 🥇'), // Page 0
    SessionPage(), // Page 1
    ProgramPage(), // Page 2
    CalendarPage(), // Page 3 (Ajout de la page calendrier)
    SettingsPage(), // Page 4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Séances',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Programmes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendrier', // Ajout de l'onglet calendrier
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[800],
        unselectedItemColor: Colors.deepPurple[300],
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}
