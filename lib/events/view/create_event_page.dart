import 'dart:collection';

import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum EventType { meeting, study, training }

class CreateEditEventPage extends StatefulWidget {
  const CreateEditEventPage({
    Key? key,
    required this.type,
    required this.date,
  }) : super(key: key);

  final EventType type;
  final DateTime date;

  static Route<CreateEditEventPage> route({
    required EventType type,
    required DateTime date,
  }) {
    return MaterialPageRoute<CreateEditEventPage>(
      builder: (_) => CreateEditEventPage(type: type, date: date),
    );
  }

  @override
  _CreateEditEventPageState createState() => _CreateEditEventPageState();
}

class _CreateEditEventPageState extends State<CreateEditEventPage> {
  late LinkedHashMap<String, bool> daysSelected;
  late DateTime dateFinal = widget.date;

  String _getTitle() {
    switch (widget.type) {
      case EventType.meeting:
        return 'Crear una reunión';
      case EventType.study:
        return 'Crear estudio';
      case EventType.training:
        return 'Crear un entreno';
      default:
        return 'Crear un evento';
    }
  }

  @override
  void initState() {
    super.initState();
    daysSelected = LinkedHashMap.of({
      'L': false,
      'M': false,
      'X': false,
      'J': false,
      'V': false,
      'S': false,
      'D': false,
    });
    daysSelected[daysSelected.entries.elementAt(widget.date.weekday - 1).key] =
        true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getTitle())),
      body: Padding(
        padding: const EdgeInsets.only(top: 38, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Se repite el', style: BravalTextStyle.headline4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: daysSelected.entries
                  .map(
                    (e) => InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => setState(() {
                        daysSelected[e.key] = !e.value;
                      }),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: e.value
                              ? BravalColors.oceanGreen
                              : BravalColors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text(e.key)),
                      ),
                    ),
                  )
                  .toList(),
            ),
            BravalSpaces.elementsSeparator,
            Text('Empieza', style: BravalTextStyle.headline4),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: BravalColors.shark,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  DateFormat('dd MMM yyyy', 'es').format(widget.date),
                ),
              ),
            ),
            BravalSpaces.elementsSeparator,
            Text('Termina el', style: BravalTextStyle.headline4),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: BravalColors.shark,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  DateFormat('dd MMM yyyy', 'es').format(dateFinal),
                ),
              ),
            ),
            BravalSpaces.elementsSeparator,
            Text('Hora', style: BravalTextStyle.headline4),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: BravalColors.shark,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: const Text('18:00'),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('GUARDAR'),
                  ),
                ),
              ),
            ),
            BravalSpaces.elementsSeparator,
            BravalSpaces.elementsSeparator,
          ],
        ),
      ),
    );
  }
}
