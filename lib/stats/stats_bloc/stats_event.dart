part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object> get props => [];
}

class PlayerListStatsFetchRequested extends StatsEvent {
  const PlayerListStatsFetchRequested(this.playerIdList);
  final List<String> playerIdList;

  @override
  List<Object> get props => [playerIdList];
}

class PlayerListStatsPostRequested extends StatsEvent {
  const PlayerListStatsPostRequested(this.events);
  final FootballBravalStats events;

  @override
  List<Object> get props => [events];
}
