import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_repository/calendar_repository.dart';

import 'package:braval_ui/braval_ui.dart';

class BravalTableCalendar extends StatefulWidget {
  const BravalTableCalendar({
    Key? key,
    required this.events,
  }) : super(key: key);

  final List<Event>? events;

  @override
  _BravalTableCalendarState createState() => _BravalTableCalendarState();
}

class _BravalTableCalendarState extends State<BravalTableCalendar> {
  DateTime dateSelected = DateTime.now();

  Color _getEventColor(Event? event) {
    if (event is Study || event is Meeting) {
      return BravalColors.study;
    } else if (event is Training) {
      return BravalColors.training;
    } else if (event is Match) {
      return BravalColors.match;
    } else {
      return BravalColors.silver;
    }
  }

  Event? _getFirstEventFromDate(DateTime date) {
    return widget.events!.firstWhere((event) => event.date!.isSameDate(date));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Event>(
      calendarBuilders: CalendarBuilders<Event>(
        singleMarkerBuilder: (context, date, list) {
          return Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getEventColor(_getFirstEventFromDate(date)),
              shape: BoxShape.circle,
            ),
          );
        },
      ),
      eventLoader: (date) {
        if (widget.events == null) return <Event>[];
        return widget.events!
            .where((event) => event.date!.isSameDate(date))
            .toList();
      },
      locale: 'es_ES',
      focusedDay: dateSelected,
      firstDay: DateTime.utc(2021, 8),
      lastDay: DateTime.utc(2022, 8, 31),
      availableCalendarFormats: const {CalendarFormat.month: 'month'},
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: BravalTextStyle.bodyText1,
        weekendStyle: BravalTextStyle.bodyText1.copyWith(
          color: BravalColors.oceanGreen,
        ),
      ),
      calendarStyle: CalendarStyle(
        selectedTextStyle: BravalTextStyle.bodyText1,
        defaultTextStyle: BravalTextStyle.bodyText1,
        todayTextStyle: BravalTextStyle.bodyText1.copyWith(
          fontWeight: FontWeight.bold,
        ),
        weekendTextStyle: BravalTextStyle.bodyText1.copyWith(
          color: BravalColors.oceanGreen,
        ),
        selectedDecoration: const BoxDecoration(
          color: BravalColors.oceanGreen,
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          color: BravalColors.shark,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: BravalTextStyle.headline3,
        leftChevronIcon: const Icon(
          Icons.chevron_left,
          color: BravalColors.oceanGreen,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right,
          color: BravalColors.oceanGreen,
        ),
      ),
      selectedDayPredicate: (date) => date == dateSelected,
      onDaySelected: _onDaySelected,
    );
  }

  void _onDaySelected(DateTime date, DateTime _) {
    setState(() {
      dateSelected = date;
    });
  }
}

extension DateTimeComparison on DateTime {
  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }
}
