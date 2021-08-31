import 'package:braval/events/view/create_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// Packages
import 'package:braval_ui/braval_ui.dart';

// Events
import 'package:braval/events/events.dart';

// Bloc
import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Calendario'),
      ),
      floatingActionButton: _SpeedDial(date: dateSelected),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  return BravalTableCalendar(
                    events: state.events,
                    onDateSelected: (date) {
                      setState(() => dateSelected = date);
                    },
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
                  onTap: () => Navigator.of(context).push(
                    EventPage.route(event: events[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpeedDial extends StatelessWidget {
  const _SpeedDial({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      overlayColor: BravalColors.shark,
      overlayOpacity: 0.5,
      foregroundColor: BravalColors.black,
      children: [
        SpeedDialChild(
          label: 'Crear partido',
          labelStyle: BravalTextStyle.caption.copyWith(
            color: BravalColors.black,
          ),
          labelBackgroundColor: BravalColors.white,
          backgroundColor: BravalColors.match,
          child: const Icon(
            Icons.emoji_events,
            color: BravalColors.black,
          ),
        ),
        SpeedDialChild(
          label: 'Crear entreno',
          labelStyle: BravalTextStyle.caption.copyWith(
            color: BravalColors.black,
          ),
          labelBackgroundColor: BravalColors.white,
          backgroundColor: BravalColors.training,
          onTap: () => Navigator.of(context).push(
            CreateEditEventPage.route(type: EventType.training, date: date),
          ),
          child: const Icon(
            Icons.fitness_center,
            color: BravalColors.black,
          ),
        ),
        SpeedDialChild(
          label: 'Crear estudio',
          labelStyle: BravalTextStyle.caption.copyWith(
            color: BravalColors.black,
          ),
          labelBackgroundColor: BravalColors.white,
          backgroundColor: BravalColors.study,
          onTap: () => Navigator.of(context).push(
            CreateEditEventPage.route(type: EventType.study, date: date),
          ),
          child: const Icon(
            Icons.menu_book,
            color: BravalColors.black,
          ),
        ),
        SpeedDialChild(
          label: 'Crear reunión',
          labelStyle: BravalTextStyle.caption.copyWith(
            color: BravalColors.black,
          ),
          labelBackgroundColor: BravalColors.white,
          backgroundColor: BravalColors.study,
          onTap: () => Navigator.of(context).push(
            CreateEditEventPage.route(type: EventType.meeting, date: date),
          ),
          child: const Icon(
            Icons.groups,
            color: BravalColors.black,
          ),
        ),
      ],
    );
  }
}
