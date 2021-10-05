import 'package:flutter/material.dart';
import 'package:team_repository/team_repository.dart';

class PlayerFootballStats extends StatelessWidget {
  const PlayerFootballStats({Key? key, required this.player}) : super(key: key);

  final TeamPlayer player;

  static Route<PlayerFootballStats> route(TeamPlayer player) =>
      MaterialPageRoute<PlayerFootballStats>(
        builder: (context) => PlayerFootballStats(player: player),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            Text('Asistencias a entrenos: '),
            Text('Asistencias a partidos: '),
            Text('Goles: '),
            Text('Faltas: '),
            Text('Tarjetas amarillas: '),
            Text('Tarjetas rojas: '),
          ],
        ),
      ),
    );
  }
}
