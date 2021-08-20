import 'package:braval/calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:braval_ui/braval_ui.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nicos Fabro'),
            Text('Fútbol infantil', style: BravalTextStyle.overline),
          ],
        ),
        actions: const [
          Icon(Icons.notifications),
        ],
      ),
      // body: ElevatedButton(
      //     onPressed: () => Navigator.push(context,
      //         MaterialPageRoute<CalendarPage>(builder: (_) => CalendarPage())),
      //     child: Text('Click')),
    );
  }
}
