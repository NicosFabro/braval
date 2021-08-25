part of 'events_bloc.dart';

enum EventsStatus {
  loading,
  success,
  failure,
}

class EventsState extends Equatable {
  const EventsState({
    this.events = const [],
    this.status = EventsStatus.loading,
  });

  final List<Event> events;
  final EventsStatus status;

  EventsState copyWith({
    List<Event>? events,
    EventsStatus? status,
  }) {
    return EventsState(
      events: events ?? this.events,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [events, status];
}

class EventsInitial extends EventsState {}
