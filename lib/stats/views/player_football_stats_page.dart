import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/stats/views/pie_chart.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_repository/team_repository.dart';

class PlayerFootballStats extends StatelessWidget {
  const PlayerFootballStats({Key? key, required this.player}) : super(key: key);

  final TeamPlayer player;

  static Route<PlayerFootballStats> route(TeamPlayer player) =>
      MaterialPageRoute<PlayerFootballStats>(
        builder: (context) => PlayerFootballStats(player: player),
      );

  List<charts.Series<Assists, int>> getTrainingAssists(BuildContext context) {
    final list = context
        .read<EventsBloc>()
        .state
        .events
        .whereType<Training>()
        .where((training) => training.date!.isBefore(DateTime.now()));
    final data = <Assists>[
      Assists(0, player.assistanceTraining),
      Assists(
        1,
        list.isEmpty ? 0 : list.length - player.assistanceTraining,
      ),
    ];

    return [
      charts.Series<Assists, int>(
        id: 'Training assists',
        domainFn: (Assists assits, _) => assits.label,
        measureFn: (Assists assits, _) => assits.value,
        data: data,
        labelAccessorFn: (Assists row, _) {
          if (row.label == 0) {
            return 'Asistidos: ${row.value}';
          } else {
            return 'No asistidos: ${row.value}';
          }
        },
      ),
    ];
  }

  List<charts.Series<Assists, int>> getMatchAssists(BuildContext context) {
    final list = context
        .read<EventsBloc>()
        .state
        .events
        .whereType<Match>()
        .where((match) => match.date!.isBefore(DateTime.now()));

    final data = <Assists>[
      Assists(0, player.assistanceMatch),
      Assists(
        1,
        list.isEmpty ? 0 : list.length - player.assistanceMatch,
      ),
    ];

    return [
      charts.Series<Assists, int>(
        id: 'Training assists',
        domainFn: (Assists assits, _) => assits.label,
        measureFn: (Assists assits, _) => assits.value,
        data: data,
        labelAccessorFn: (Assists row, _) {
          if (row.label == 0) {
            return 'Asistidos: ${row.value}';
          } else {
            return 'No asistidos: ${row.value}';
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 38),
          shrinkWrap: true,
          children: [
            const Text('Asistencias a entrenos: '),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: PieOutsideLabelChart(getTrainingAssists(context)),
            ),
            const Text('Asistencias a partidos: '),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: PieOutsideLabelChart(getMatchAssists(context)),
            ),
            Text('Goles: ${player.goals}'),
            Text('Faltas: ${player.fouls}'),
            Text('Tarjetas amarillas: ${player.yellowCards}'),
            Text('Tarjetas rojas: ${player.redCards}'),
          ],
        ),
      ),
    );
  }
}

class Assists {
  const Assists(this.label, this.value);
  final int label;
  final int value;
}
