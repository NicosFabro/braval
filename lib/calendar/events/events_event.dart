part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class EventsFetchRequested extends EventsEvent {
  const EventsFetchRequested(this.teamId);
  final String teamId;

  @override
  List<Object> get props => [teamId];
}

class EventsUpdated extends EventsEvent {
  const EventsUpdated(this.events);
  final List<Event> events;

  @override
  List<Object> get props => [events];
}
