import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Packages
import 'package:braval_ui/braval_ui.dart';

// Bloc
import 'package:braval/calendar/events/events_bloc.dart';

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
