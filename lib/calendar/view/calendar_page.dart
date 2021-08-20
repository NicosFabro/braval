import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Calendario'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                BravalTableCalendar(),
                BravalSpaces.elementsSeparator,
                Divider(),
                BravalSpaces.elementsSeparator,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
