import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/team.dart';
import 'match_screen.dart';
import 'create_team_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Team> teamBox;

  @override
  void initState() {
    super.initState();
    teamBox = Hive.box<Team>('teams');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: ValueListenableBuilder(
        valueListenable: teamBox.listenable(),
        builder: (context, Box<Team> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('Aucune équipe créée'));
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Team team = box.getAt(index)!;
              return ListTile(
                title: Text(team.name),
                subtitle: Text('Joueurs: ${team.players.map((p) => p.name).join(', ')}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchScreen(team: team),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTeamScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
