import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/player.dart';
import 'models/team.dart';
import 'models/match.dart';
import 'screens/home_screen.dart';
import 'screens/team_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(TeamAdapter());
  Hive.registerAdapter(MatchAdapter());
  Hive.registerAdapter(PlayerStatsAdapter());
  await Hive.openBox<Team>('teams');
  await Hive.openBox<Match>('matches');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Stats App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TeamScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Teams',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
