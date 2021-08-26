import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  final Event event;
  final Function() onTap;

  Icon _getEventIcon() {
    switch (event.runtimeType) {
      case Meeting:
        return const Icon(Icons.groups, color: BravalColors.study);
      case Study:
        return const Icon(Icons.menu_book, color: BravalColors.study);
      case Match:
        return const Icon(Icons.emoji_events, color: BravalColors.study);
      case Training:
        return const Icon(Icons.fitness_center, color: BravalColors.training);
      default:
        return const Icon(Icons.calendar_today, color: BravalColors.oceanGreen);
    }
  }

  String _getTypeString() {
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

  String _getDateFormated() => DateFormat('kk:mm').format(event.date!);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 67,
        margin: const EdgeInsets.only(bottom: BravalSpaces.betweenElements),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: BravalColors.shark,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: _getEventIcon(),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_getTypeString(), style: BravalTextStyle.headline6),
                  Text(_getDateFormated(), style: BravalTextStyle.bodyText2),
                ],
              ),
            ),
            const Expanded(
              flex: 2,
              child: Icon(Icons.visibility, color: BravalColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
