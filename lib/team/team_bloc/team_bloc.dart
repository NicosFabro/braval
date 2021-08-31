import 'dart:async';

import 'package:bloc/bloc.dart';
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
    }
  }

  Stream<TeamState> _mapTeamFetchRequestedToState(
    TeamFetchRequested event,
  ) async* {
    yield state.copyWith(status: TeamStatus.loading);
    try {
      final team = await teamRepository.getTeamById(event.teamId);
      yield state.copyWith(status: TeamStatus.success, team: team);
    } catch (_) {
      yield state.copyWith(status: TeamStatus.failure);
    }
  }
}
