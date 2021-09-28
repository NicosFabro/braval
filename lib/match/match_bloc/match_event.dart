part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class StartGameRequested extends MatchEvent {}

class FinishGameRequested extends MatchEvent {}

class NextStageRequested extends MatchEvent {}

class AddStatRequested extends MatchEvent {
  const AddStatRequested(this.event, this.minute, this.playerId);

  final String event;
  final int minute;
  final String playerId;

  @override
  List<Object> get props => [event, minute, playerId];
}
