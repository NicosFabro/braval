part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamFetchRequested extends TeamEvent {
  const TeamFetchRequested(this.teamId);
  final String teamId;

  @override
  List<Object> get props => [teamId];
}

class UpdatePlayerStatsRequested extends TeamEvent {
  const UpdatePlayerStatsRequested(this.teamId, this.matchEvents);
  final String teamId;
  final FootballBravalStats matchEvents;

  @override
  List<Object> get props => [teamId, matchEvents];
}
