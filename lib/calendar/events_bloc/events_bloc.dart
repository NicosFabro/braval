import 'dart:async';

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({
    required this.calendarRepository,
  }) : super(EventsInitial());

  final CalendarRepository calendarRepository;
  StreamSubscription? _eventsSubscription;

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent event,
  ) async* {
    if (event is EventsFetchRequested) {
      yield* _mapEventsFetchRequestedToState(event);
    } else if (event is EventsUpdated) {
      yield* _mapEventsUpdatedToState(event);
    }
  }

  Stream<EventsState> _mapEventsFetchRequestedToState(
    EventsFetchRequested event,
  ) async* {
    yield state.copyWith(status: EventsStatus.loading);
    await _eventsSubscription?.cancel();
    try {
      final meetings = calendarRepository.getAllMeetings(event.teamId);
      final matches = calendarRepository.getAllMatches(event.teamId);
      final study = calendarRepository.getAllStudy(event.teamId);
      final trainings = calendarRepository.getAllTrainings(event.teamId);

      final eventsStream = StreamZip([
        meetings,
        matches,
        study,
        trainings,
      ]).asBroadcastStream();

      _eventsSubscription = eventsStream.listen((eventsList) {
        final e = <Event>[];
        eventsList.forEach(e.addAll);
        add(EventsUpdated(e));
      });
    } catch (_) {
      yield state.copyWith(status: EventsStatus.failure);
    }
  }

  Stream<EventsState> _mapEventsUpdatedToState(
    EventsUpdated event,
  ) async* {
    yield state.copyWith(
      events: event.events,
      status: EventsStatus.success,
    );
  }
}
