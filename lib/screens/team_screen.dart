import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
      body: ListView.builder(
        itemCount: teamBox.length,
        itemBuilder: (context, index) {
          Team team = teamBox.getAt(index) as Team;
          List<Match> matches = matchBox.values.where((match) => match.playerStats.any((stats) => team.players.any((player) => player.name == stats.playerName))).toList();

          return ExpansionTile(
            title: Text(team.name),
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
                      return Text(
                        'Match ${match.date.toLocal().toString().split(' ')[0]}: ${stats.points} points, ${stats.rebounds} rebounds, ${stats.assists} assists, ${stats.steals} steals, ${stats.blocks} blocks, ${stats.turnovers} turnovers, FT: ${stats.ftMade}/${stats.ftMissed}, 2PT: ${stats.twoPtMade}/${stats.twoPtMissed}, 3PT: ${stats.threePtMade}/${stats.threePtMissed}',
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
