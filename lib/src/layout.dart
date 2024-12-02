import 'package:flutter/material.dart';
import 'package:gymbros/src/features/auth/page/login_page.dart';
import 'package:gymbros/src/features/auth/page/signup_page.dart';
import 'package:gymbros/src/home.dart';
import 'package:gymbros/src/features/session/page/session_page.dart';
import 'package:gymbros/src/features/program/page/program_page.dart';
import 'package:gymbros/src/features/settings/page/settings_page.dart';

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
      home: LoginPage(), // Start with the login page
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const MainNavigation(),
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
    MyHomePage(title: 'GymbrOS App'), // Page 0
    SessionPage(), // Page 1
    ProgramPage(), // Page 2
    SettingsPage(), // Page 3
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
            label: 'Seances',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Programmes',
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
