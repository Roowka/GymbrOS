import 'package:flutter/material.dart';
import 'package:gymbros/src/features/auth/page/login_page.dart';
import 'package:gymbros/src/features/auth/page/signup_page.dart';
import 'package:gymbros/src/home.dart';
import 'package:gymbros/src/features/session/page/session_page.dart';
import 'package:gymbros/src/features/program/page/program_page.dart';
import 'package:gymbros/src/features/settings/page/settings_page.dart';
import 'package:gymbros/src/features/calendar/calendar_page.dart'; // Import de la page calendrier

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State to manage theme mode
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymbrOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.black), // Label clair
          hintStyle: const TextStyle(
              color: Colors.black54), // Texte d'indication clair
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple[800]!),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(color: Colors.black), // Texte clair
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.white), // Label sombre
          hintStyle: const TextStyle(
              color: Colors.white70), // Texte d'indication sombre
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: const TextStyle(color: Colors.white), // Texte sombre
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[800],
          ),
        ),
      ),
      themeMode: _themeMode,
      home: MainNavigation(onToggleTheme: toggleTheme),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => MainNavigation(onToggleTheme: toggleTheme),
        '/calendar': (context) =>
            const CalendarPage(), // Ajout de la route calendrier
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
  final VoidCallback onToggleTheme;

  const MainNavigation({super.key, required this.onToggleTheme});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Liste des pages
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MyHomePage(
          title: 'GymbrOS App', onToggleTheme: widget.onToggleTheme), // Page 0
      SessionPage(), // Page 1
      ProgramPage(), // Page 2
      SettingsPage(), // Page 3
    ];
  }

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
