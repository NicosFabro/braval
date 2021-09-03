import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:braval_ui/braval_ui.dart';

import 'package:braval/events/event_cubit/event_cubit.dart';

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
      builder: (_) => BlocProvider(
        create: (context) => EventCubit(
          context.read<CalendarRepository>(),
          type: type,
          daysSelected: {
            'L': false,
            'M': false,
            'X': false,
            'J': false,
            'V': false,
            'S': false,
            'D': false,
          },
          dateStart: date,
          hour: const TimeOfDay(hour: 18, minute: 00),
        ),
        child: CreateEditEventPage(type: type, date: date),
      ),
    );
  }

  @override
  _CreateEditEventPageState createState() => _CreateEditEventPageState();
}

class _CreateEditEventPageState extends State<CreateEditEventPage> {
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

  Future<DateTimeRange?> _showDatePicker(DateTimeRange? dateRange) async {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime.utc(2021, 8),
      lastDate: DateTime.utc(2022, 8, 31),
      initialDateRange: dateRange,
    );
  }

  Future<TimeOfDay?> _showTimePicker() async {
    return showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 00),
    );
  }

  Future<void> _onSave() async {
    final teamId = context.read<ProfileBloc>().state.profile.currentTeam;
    final event = context.read<EventCubit>();
    await event.saveEvent(teamId);
  }

  @override
  void initState() {
    super.initState();
    final event = context.read<EventCubit>();
    final map = event.state.daysSelected;
    final key = map.entries.elementAt(widget.date.weekday - 1).key;
    map[key] = true;
    event.emit(event.state.copyWith(daysSelected: map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getTitle())),
      body: Padding(
        padding: const EdgeInsets.only(top: 38, left: 16, right: 16),
        child: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            if (state.status == EventStatus.success) {
              final teamId =
                  context.read<ProfileBloc>().state.profile.currentTeam;
              context.read<EventsBloc>().add(EventsFetchRequested(teamId));
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final event = context.read<EventCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Se repite el', style: BravalTextStyle.headline4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: state.daysSelected.entries
                      .map(
                        (e) => InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            state.daysSelected[e.key] = !e.value;
                            event.emit(state.copyWith(
                              daysSelected: state.daysSelected,
                            ));
                            setState(() {});
                          },
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
                  onTap: () async {
                    final dates = await _showDatePicker(DateTimeRange(
                      start: state.dateStart,
                      end: state.dateEnd,
                    ));
                    if (dates == null) return;

                    event.emit(state.copyWith(
                      dateStart: dates.start,
                      dateEnd: dates.end,
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: BravalColors.shark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      DateFormat('dd MMM yyyy', 'es').format(state.dateStart),
                    ),
                  ),
                ),
                BravalSpaces.elementsSeparator,
                Text('Termina el', style: BravalTextStyle.headline4),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    final dates = await _showDatePicker(DateTimeRange(
                      start: state.dateStart,
                      end: state.dateEnd,
                    ));
                    if (dates == null) return;

                    event.emit(state.copyWith(
                      dateStart: dates.start,
                      dateEnd: dates.end,
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: BravalColors.shark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      DateFormat('dd MMM yyyy', 'es').format(state.dateEnd),
                    ),
                  ),
                ),
                BravalSpaces.elementsSeparator,
                Text('Hora', style: BravalTextStyle.headline4),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    final time = await _showTimePicker();
                    if (time == null) return;

                    event.emit(state.copyWith(hour: time));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: BravalColors.shark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(state.hour.format(context)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: _onSave,
                        child: event.state.status == EventStatus.saving
                            ? const CircularProgressIndicator()
                            : const Text('GUARDAR'),
                      ),
                    ),
                  ),
                ),
                BravalSpaces.elementsSeparator,
                BravalSpaces.elementsSeparator,
              ],
            );
          },
        ),
      ),
    );
  }
}
