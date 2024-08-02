import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/team.dart';
import '../models/player.dart';

class CreateTeamScreen extends StatefulWidget {
  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final List<TextEditingController> _playerControllers = List.generate(12, (index) => TextEditingController());

  void _createTeam() {
    if (_formKey.currentState?.validate() ?? false) {
      final String teamName = _teamNameController.text;
      final List<Player> players = _playerControllers.map((controller) => Player(name: controller.text)).toList();
      final Team newTeam = Team(name: teamName, players: players);

      final Box<Team> teamBox = Hive.box<Team>('teams');
      teamBox.add(newTeam);

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _playerControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une équipe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _teamNameController,
                decoration: InputDecoration(labelText: 'Nom de l\'équipe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom d\'équipe';
                  }
                  return null;
                },
              ),
              ..._playerControllers.map((controller) {
                int index = _playerControllers.indexOf(controller);
                return TextFormField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Nom du joueur ${index + 1}'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom de joueur';
                    }
                    return null;
                  },
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createTeam,
                child: Text('Créer l\'équipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
