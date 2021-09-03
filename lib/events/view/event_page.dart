import 'package:braval/match/match.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key, required this.event}) : super(key: key);

  final Event event;

  static Route<EventPage> route({required Event event}) =>
      MaterialPageRoute<EventPage>(builder: (_) => EventPage(event: event));

  String _getEventTypeString() {
    switch (event.runtimeType) {
      case Meeting:
        return 'Reunión';
      case Study:
        return 'Estudio';
      case Match:
        return 'Partido';
      case Training:
        return 'Entreno';
      default:
        return 'Evento';
    }
  }

  String _getDateFormatted() {
    return DateFormat('dd/MM/yyyy kk:mm').format(event.date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getEventTypeString())),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 38, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_getEventTypeString(), style: BravalTextStyle.headline4),
              BravalSpaces.elementsSeparator,
              Text(_getDateFormatted()),
              if (event.runtimeType == Match) ..._showMatchInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _showMatchInfo(BuildContext context) {
    final match = event as Match;
    final lineupProfiles = context
        .read<ProfileBloc>()
        .state
        .teamPlayersProfiles
        .where((element) => match.lineup.contains(element.id))
        .toList();
    return [
      BravalSpaces.elementsSeparator,
      SelectableText.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'Contra: '),
            TextSpan(text: match.rival, style: BravalTextStyle.button),
          ],
        ),
      ),
      BravalSpaces.elementsSeparator,
      SelectableText.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'Dirección: '),
            TextSpan(text: match.address, style: BravalTextStyle.button),
          ],
        ),
      ),
      BravalSpaces.elementsSeparator,
      BravalSpaces.elementsSeparator,
      Text('Convocados:', style: BravalTextStyle.headline6),
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lineupProfiles.length,
        itemBuilder: (context, i) {
          return PlayerAvatar(
            profile: lineupProfiles[i],
            onTap: () => null,
          );
        },
      ),
      BravalSpaces.elementsSeparator,
      Flexible(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MatchPage.route(match: event as Match),
                );
              },
              child: const Text('INICIAR PARTIDO'),
            ),
          ),
        ),
      ),
      BravalSpaces.elementsSeparator,
    ];
  }
}
