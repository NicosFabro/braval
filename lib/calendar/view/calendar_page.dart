import 'package:braval/calendar/events/events_bloc.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Packages
import 'package:braval_ui/braval_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';

// Bloc
import 'package:braval/calendar/meeting_bloc/meeting_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String teamId = context.read<ProfileBloc>().state.currentTeam;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Calendario'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CalendarView(),
        ),
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teamId = context.read<ProfileBloc>().state.profile.currentTeam;
    context.read<EventsBloc>().add(EventsFetchRequested(teamId));
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<EventsBloc, EventsState>(
            builder: (context, state) {
              return BravalTableCalendar(
                events: state.events,
              );
            },
          ),
          BravalSpaces.elementsSeparator,
          const Divider(),
          BravalSpaces.elementsSeparator,
        ],
      ),
    );
  }
}
