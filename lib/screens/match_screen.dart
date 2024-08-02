import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/player.dart';
import '../models/team.dart';
import '../models/match.dart';

class MatchScreen extends StatefulWidget {
  final Team team;

  MatchScreen({required this.team});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  late Box<Team> teamBox;
  late Box<Match> matchBox;
  late DateTime matchDate;

  @override
  void initState() {
    super.initState();
    teamBox = Hive.box<Team>('teams');
    matchBox = Hive.box<Match>('matches');
    matchDate = DateTime.now();
  }

  void updateStats(Player player, String stat) {
    setState(() {
      switch (stat) {
        case 'rebounds':
          player.rebounds += 1;
          break;
        case 'assists':
          player.assists += 1;
          break;
        case 'steals':
          player.steals += 1;
          break;
        case 'blocks':
          player.blocks += 1;
          break;
        case 'turnovers':
          player.turnovers += 1;
          break;
        case 'points':
          player.points += 1;
          break;
        case 'ftMade':
          player.ftMade += 1;
          break;
        case 'ftMissed':
          player.ftMissed += 1;
          break;
        case 'twoPtMade':
          player.twoPtMade += 1;
          break;
        case 'twoPtMissed':
          player.twoPtMissed += 1;
          break;
        case 'threePtMade':
          player.threePtMade += 1;
          break;
        case 'threePtMissed':
          player.threePtMissed += 1;
          break;
      }
    });
  }

  void resetPlayerStats(Player player) {
    player.rebounds = 0;
    player.assists = 0;
    player.steals = 0;
    player.blocks = 0;
    player.turnovers = 0;
    player.points = 0;
    player.ftMade = 0;
    player.ftMissed = 0;
    player.twoPtMade = 0;
    player.twoPtMissed = 0;
    player.threePtMade = 0;
    player.threePtMissed = 0;
  }

  void endMatch() {
    List<PlayerStats> playerStats = widget.team.players.map((player) {
      return PlayerStats(
        playerName: player.name,
        rebounds: player.rebounds,
        assists: player.assists,
        steals: player.steals,
        blocks: player.blocks,
        turnovers: player.turnovers,
        points: player.points,
        ftMade: player.ftMade,
        ftMissed: player.ftMissed,
        twoPtMade: player.twoPtMade,
        twoPtMissed: player.twoPtMissed,
        threePtMade: player.threePtMade,
        threePtMissed: player.threePtMissed,
      );
    }).toList();

    Match match = Match(date: matchDate, playerStats: playerStats);
    matchBox.add(match);

    // Réinitialiser les statistiques des joueurs
    widget.team.players.forEach(resetPlayerStats);

    // Mettre à jour la boîte d'équipes
    teamBox.put(widget.team.name, widget.team);

    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    // Afficher une boîte de dialogue de confirmation
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Annuler le match'),
            content: Text('Voulez-vous vraiment quitter sans enregistrer les stats du match ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Non'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Oui'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Match: ${widget.team.name}'),
        ),
        body: ListView.builder(
          itemCount: widget.team.players.length,
          itemBuilder: (context, index) {
            Player player = widget.team.players[index];
            return ListTile(
              title: Text(player.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rebonds: ${player.rebounds}'),
                  Text('Assists: ${player.assists}'),
                  Text('Interceptions: ${player.steals}'),
                  Text('Contres: ${player.blocks}'),
                  Text('Turnovers: ${player.turnovers}'),
                  Text('Points: ${player.points}'),
                  Text('1 pt: ${player.ftMade}/${player.ftMissed + player.ftMade}'),
                  Text('2 pts: ${player.twoPtMade}/${player.twoPtMissed + player.twoPtMade}'),
                  Text('3 pts: ${player.threePtMade}/${player.threePtMissed + player.threePtMade}'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'rebounds'),
                          child: Text('Rebond'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'assists'),
                          child: Text('Assist'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'steals'),
                          child: Text('Interception'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'blocks'),
                          child: Text('Contre'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'turnovers'),
                          child: Text('Turnover'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'ftMade'),
                          child: Text('1 pt réussi'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'ftMissed'),
                          child: Text('1 pt manqué'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'twoPtMade'),
                          child: Text('2 pts réussi'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'twoPtMissed'),
                          child: Text('2 pts manqué'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'threePtMade'),
                          child: Text('3 pts réussi'),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStats(player, 'threePtMissed'),
                          child: Text('3 pts manqué'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: endMatch,
          child: Icon(Icons.stop),
        ),
      ),
    );
  }
}
