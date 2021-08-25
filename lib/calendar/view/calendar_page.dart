import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Packages
import 'package:braval_ui/braval_ui.dart';

// Bloc
import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Calendario'),
      ),
      body: const SafeArea(
        child: CalendarView(),
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime dateSelected = DateTime.now();

  @override
  void initState() {
    super.initState();
    final teamId = context.read<ProfileBloc>().state.profile.currentTeam;
    context.read<EventsBloc>().add(EventsFetchRequested(teamId));
  }

  @override
  Widget build(BuildContext context) {
    final events = context
        .read<EventsBloc>()
        .state
        .events
        .where((event) => event.date!.isSameDate(dateSelected))
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            BlocBuilder<EventsBloc, EventsState>(
              builder: (context, state) {
                return BravalTableCalendar(
                  events: state.events,
                  onDateSelected: (date) => setState(() => dateSelected = date),
                );
              },
            ),
            BravalSpaces.elementsSeparator,
            const Divider(),
            BravalSpaces.elementsSeparator,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, i) => EventTile(
                event: events[i],
                onTap: () => print(events[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
