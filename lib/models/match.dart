import 'package:hive/hive.dart';
import 'player.dart';

part 'match.g.dart';

@HiveType(typeId: 2)
class Match {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<PlayerStats> playerStats;

  Match({required this.date, required this.playerStats});
}

@HiveType(typeId: 3)
class PlayerStats {
  @HiveField(0)
  String playerName;

  @HiveField(1)
  int rebounds;

  @HiveField(2)
  int assists;

  @HiveField(3)
  int steals;

  @HiveField(4)
  int blocks;

  @HiveField(5)
  int turnovers;

  @HiveField(6)
  int points;

  @HiveField(7)
  int ftMade;

  @HiveField(8)
  int ftMissed;

  @HiveField(9)
  int twoPtMade;

  @HiveField(10)
  int twoPtMissed;

  @HiveField(11)
  int threePtMade;

  @HiveField(12)
  int threePtMissed;

  PlayerStats({
    required this.playerName,
    this.rebounds = 0,
    this.assists = 0,
    this.steals = 0,
    this.blocks = 0,
    this.turnovers = 0,
    this.points = 0,
    this.ftMade = 0,
    this.ftMissed = 0,
    this.twoPtMade = 0,
    this.twoPtMissed = 0,
    this.threePtMade = 0,
    this.threePtMissed = 0,
  });
}
