import 'package:braval_ui/braval_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(top: 38, left: 16, right: 16),
        child: Center(
          child: Column(
            children: [
              Text(_getEventTypeString(), style: BravalTextStyle.headline4),
              BravalSpaces.elementsSeparator,
              Text(_getDateFormatted()),
            ],
          ),
        ),
      ),
    );
  }
}
