import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:team_repository/team_repository.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc({required this.teamRepository}) : super(const TeamState());

  final TeamRepository teamRepository;

  @override
  Stream<TeamState> mapEventToState(
    TeamEvent event,
  ) async* {
    if (event is TeamFetchRequested) {
      yield* _mapTeamFetchRequestedToState(event);
    } else if (event is UpdatePlayerStatsRequested) {
      yield* _mapUpdatePlayerStatsRequestedToState(event);
    }
  }

  Stream<TeamState> _mapTeamFetchRequestedToState(
    TeamFetchRequested event,
  ) async* {
    yield state.copyWith(status: TeamStatus.loading);
    try {
      final team = await teamRepository.getTeamById(event.teamId);
      yield state.copyWith(status: TeamStatus.success, team: team);
    } on Exception catch (e) {
      log(e.toString());
      yield state.copyWith(status: TeamStatus.failure);
    }
  }

  Stream<TeamState> _mapUpdatePlayerStatsRequestedToState(
    UpdatePlayerStatsRequested event,
  ) async* {
    yield state.copyWith(status: TeamStatus.loading);
    try {
      final team = state.team.copyWith();

      for (final id in event.match.lineup) {
        final playerIndex = team.players!.indexWhere((p) => p.id == id);
        var player = team.players![playerIndex];
        player = player.copyWith(assistanceMatch: player.assistanceMatch + 1);
        team.players![playerIndex] = player;
      }

      for (final goal in event.matchEvents.goals) {
        final playerIndex = team.players!.indexWhere(
          (p) => p.id == goal['player'],
        );
        var player = team.players![playerIndex];
        player = player.copyWith(goals: player.goals + 1);
        team.players![playerIndex] = player;
      }

      for (final foul in event.matchEvents.fouls) {
        final playerIndex = team.players!.indexWhere(
          (p) => p.id == foul['player'],
        );
        var player = team.players![playerIndex];
        player = player.copyWith(fouls: player.fouls + 1);
        team.players![playerIndex] = player;
      }

      for (final yellowCard in event.matchEvents.yellowCards) {
        final playerIndex = team.players!.indexWhere(
          (p) => p.id == yellowCard['player'],
        );
        var player = team.players![playerIndex];
        player = player.copyWith(yellowCards: player.yellowCards + 1);
        team.players![playerIndex] = player;
      }

      for (final redCard in event.matchEvents.redCards) {
        final playerIndex = team.players!.indexWhere(
          (p) => p.id == redCard['player'],
        );
        var player = team.players![playerIndex];
        player = player.copyWith(redCards: player.redCards + 1);
        team.players![playerIndex] = player;
      }

      await teamRepository.updatePlayerListStats(event.teamId, team.players!);

      yield state.copyWith(status: TeamStatus.success, team: team);
    } on Exception {
      yield state.copyWith(status: TeamStatus.failure);
    }
  }

  Future<void> updateStudyEvaluation(String teamId, TeamPlayer player) async {
    try {
      await teamRepository.updatePlayerStats(teamId, player);
      add(TeamFetchRequested(teamId));
    } on Exception {}
  }
}
