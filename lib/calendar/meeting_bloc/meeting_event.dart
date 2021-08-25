part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class MeetingsFetchRequested extends MeetingEvent {
  const MeetingsFetchRequested(this.teamId);
  final String teamId;

  @override
  List<Object> get props => [teamId];
}

class MeetingsUpdated extends MeetingEvent {
  const MeetingsUpdated(this.meetings);
  final List<Meeting> meetings;

  @override
  List<Object> get props => [meetings];
}
