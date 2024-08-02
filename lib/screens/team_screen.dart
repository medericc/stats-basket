import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/player.dart';
import '../models/team.dart';
import '../models/match.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamBox = Hive.box<Team>('teams');
    final matchBox = Hive.box<Match>('matches');

    return Scaffold(
      appBar: AppBar(title: Text('Teams and Matches')),
      body: ValueListenableBuilder(
        valueListenable: teamBox.listenable(),
        builder: (context, Box<Team> teams, _) {
          if (teams.isEmpty) {
            return Center(child: Text('No teams found'));
          }

          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              Team team = teams.getAt(index)!;
              List<Match> matches = matchBox.values.where((match) => match.playerStats.any((stats) => team.players.any((player) => player.name == stats.playerName))).toList();

              return ExpansionTile(
                title: Text(team.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, team, index, teamBox);
                  },
                ),
                children: [
                  ...team.players.map((player) {
                    return ListTile(
                      title: Text(player.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: matches.map((match) {
                          PlayerStats stats = match.playerStats.firstWhere(
                            (stats) => stats.playerName == player.name,
                            orElse: () => PlayerStats(playerName: player.name),
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Match ${match.date.toLocal().toString().split(' ')[0]}: '
                              '${stats.points} points, ${stats.rebounds} rebounds, '
                              '${stats.assists} assists, ${stats.steals} steals, '
                              '${stats.blocks} blocks, ${stats.turnovers} turnovers, '
                              'FT: ${stats.ftMade}/${stats.ftMissed + stats.ftMade}, '
                              '2PT: ${stats.twoPtMade}/${stats.twoPtMissed + stats.twoPtMade}, '
                              '3PT: ${stats.threePtMade}/${stats.threePtMissed + stats.threePtMade}',
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Team team, int index, Box<Team> teamBox) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Team'),
          content: Text('Are you sure you want to delete the team ${team.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                teamBox.deleteAt(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
