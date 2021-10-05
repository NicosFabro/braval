import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/stats/views/pie_chart.dart';
import 'package:braval/team/team.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:team_repository/team_repository.dart';

class PlayerFootballStats extends StatelessWidget {
  const PlayerFootballStats({
    Key? key,
    required this.player,
    required this.profile,
  }) : super(key: key);

  final TeamPlayer player;
  final Profile profile;

  static Route<PlayerFootballStats> route(TeamPlayer player, Profile profile) =>
      MaterialPageRoute<PlayerFootballStats>(
        builder: (context) => PlayerFootballStats(
          player: player,
          profile: profile,
        ),
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

  Future<void> openEvaluateDialog(
    BuildContext context,
    double initialEvaluation,
  ) async {
    var evaluation = 0.0;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Evalúa a ${profile.name}'),
          content: TextField(
            controller: TextEditingController(text: '$initialEvaluation'),
            keyboardType: TextInputType.number,
            onChanged: (value) => evaluation = double.parse(value),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.read<TeamBloc>().updateStudyEvaluation(
                      context.read<TeamBloc>().state.team.id,
                      player.copyWith(evaluationMatch: evaluation),
                    );
                Navigator.pop(context);
              },
              child: const Text('GUARDAR'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas de fútbol de ${profile.name}'),
      ),
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
            BravalSpaces.elementsSeparator,
            ElevatedButton(
              onPressed: () async =>
                  openEvaluateDialog(context, player.evaluationMatch),
              child: Text(
                'Evaluar jugador',
                style: BravalTextStyle.button,
              ),
            ),
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
