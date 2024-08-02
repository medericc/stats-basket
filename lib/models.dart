// lib/models.dart
class Player {
  String name;
  int rebounds = 0;
  int assists = 0;
  int steals = 0;
  int blocks = 0;
  int turnovers = 0;
  int points = 0;
  int ftMade = 0;
  int ftMissed = 0;
  int twoPtMade = 0;
  int twoPtMissed = 0;
  int threePtMade = 0;
  int threePtMissed = 0;

  Player({required this.name});
}

class Team {
  String name;
  List<Player> players;

  Team({required this.name, required this.players});
}
