import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc({
    required this.calendarRepository,
  }) : super(const MeetingState());

  final CalendarRepository calendarRepository;
  StreamSubscription? _calendarSubscription;

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is MeetingsFetchRequested) {
      yield* _mapMeetingsFetchRequestedToState(event);
    } else if (event is MeetingsUpdated) {
      yield* _mapMeetingsUpdatedToState(event);
    }
  }

  Stream<MeetingState> _mapMeetingsFetchRequestedToState(
    MeetingsFetchRequested event,
  ) async* {
    yield state.copyWith(status: MeetingStatus.loading);
    await _calendarSubscription?.cancel();
    try {
      _calendarSubscription = calendarRepository
          .getAllMeetings(event.teamId)
          .listen((meetings) => add(MeetingsUpdated(meetings)));
    } catch (_) {
      yield state.copyWith(status: MeetingStatus.failure);
    }
  }

  Stream<MeetingState> _mapMeetingsUpdatedToState(
    MeetingsUpdated event,
  ) async* {
    yield state.copyWith(
      meetings: event.meetings,
      status: MeetingStatus.success,
    );
  }
}
