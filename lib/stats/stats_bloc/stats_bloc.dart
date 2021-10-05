import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:stats_repository/stats_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({
    required this.statsRepository,
  }) : super(const StatsState());

  final StatsRepository statsRepository;

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is PlayerListStatsFetchRequested) {
      yield* _mapPlayerListStatsFetchRequestedToState(event);
    } else if (event is PlayerListStatsPostRequested) {
      yield* _mapPlayerListStatsPostRequestedToState(event);
    }
  }

  Stream<StatsState> _mapPlayerListStatsFetchRequestedToState(
    PlayerListStatsFetchRequested event,
  ) async* {
    yield state.copyWith(status: StatsStatus.loading);
    try {
      final stats = await statsRepository.getPlayerListStats(
          playerIds: event.playerIdList);
      yield state.copyWith(status: StatsStatus.success, stats: stats);
    } on Exception {
      yield state.copyWith(status: StatsStatus.failure);
    }
  }

  Stream<StatsState> _mapPlayerListStatsPostRequestedToState(
    PlayerListStatsPostRequested event,
  ) async* {
    yield state.copyWith(status: StatsStatus.loading);
    try {
      final stats = state.stats.toList();

      for (final element in event.events.goals) {
        final player = stats.firstWhere(
          (stat) => stat.playerId == element['player'],
          orElse: () => PlayerStats.empty,
        );
        if (player.isNotEmpty) {
          final playerStats = player.copyWith(goals: player.goals + 1);
          final index = stats.indexWhere(
              (element) => element.playerId == playerStats.playerId);
          stats[index] = playerStats;
        }
      }

      for (final element in event.events.fouls) {
        final player = stats.firstWhere(
          (stat) => stat.playerId == element['player'],
          orElse: () => PlayerStats.empty,
        );
        if (player.isNotEmpty) {
          final playerStats = player.copyWith(fouls: player.fouls + 1);
          final index = stats.indexWhere(
              (element) => element.playerId == playerStats.playerId);
          stats[index] = playerStats;
        }
      }

      for (final element in event.events.yellowCards) {
        final player = stats.firstWhere(
          (stat) => stat.playerId == element['player'],
          orElse: () => PlayerStats.empty,
        );
        if (player.isNotEmpty) {
          final playerStats =
              player.copyWith(yellowCards: player.yellowCards + 1);
          final index = stats.indexWhere(
              (element) => element.playerId == playerStats.playerId);
          stats[index] = playerStats;
        }
      }

      for (final element in event.events.redCards) {
        final player = stats.firstWhere(
          (stat) => stat.playerId == element['player'],
          orElse: () => PlayerStats.empty,
        );
        if (player.isNotEmpty) {
          final playerStats = player.copyWith(redCards: player.redCards + 1);
          final index = stats.indexWhere(
              (element) => element.playerId == playerStats.playerId);
          stats[index] = playerStats;
        }
      }

      yield state.copyWith(stats: stats, status: StatsStatus.success);
    } on Exception {
      yield state.copyWith(status: StatsStatus.failure);
    }
  }
}
