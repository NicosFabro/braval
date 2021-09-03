import 'dart:developer';

import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:braval/events/view/create_event_page.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(
    this._calendarRepository, {
    required EventType type,
    required Map<String, bool> daysSelected,
    required DateTime dateStart,
    required TimeOfDay hour,
  }) : super(EventState(
          type: type,
          daysSelected: daysSelected,
          dateStart: dateStart,
          dateEnd: dateStart,
          hour: hour,
        ));

  final CalendarRepository _calendarRepository;

  Future<void> saveEvent(String teamId) async {
    emit(state.copyWith(status: EventStatus.saving));
    try {
      final events = <Event>[];

      final start = state.dateStart;
      final end = state.dateEnd;

      for (var i = 0; i <= end.difference(start).inDays; i++) {
        final date = start.add(Duration(
          days: i,
          hours: state.hour.hour,
          minutes: state.hour.minute,
        ));

        if (state.daysSelected.entries.elementAt(date.weekday - 1).value) {
          Event event;
          switch (state.type) {
            case EventType.meeting:
              event = Meeting(id: '', date: date);
              break;
            case EventType.study:
              event = Study(id: '', date: date);
              break;
            case EventType.training:
              event = Training(id: '', date: date);
              break;
          }
          events.add(event);
        }
      }

      switch (state.type) {
        case EventType.meeting:
          await _calendarRepository.postMeeting(
            teamId: teamId,
            meetings: events.cast<Meeting>(),
          );
          break;
        case EventType.study:
          await _calendarRepository.postStudy(
            teamId: teamId,
            studyList: events.cast<Study>(),
          );
          break;
        case EventType.training:
          await _calendarRepository.postTraining(
            teamId: teamId,
            trainings: events.cast<Training>(),
          );
          break;
      }

      emit(state.copyWith(status: EventStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: EventStatus.failure));
    }
  }
}

extension DateTimeComparison on DateTime {
  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }
}
