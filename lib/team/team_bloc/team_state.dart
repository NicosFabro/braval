part of 'team_bloc.dart';

enum TeamStatus {
  loading,
  success,
  failure,
}

class TeamState extends Equatable {
  const TeamState({
    this.team = Team.empty,
    this.status = TeamStatus.loading,
  });

  final Team team;
  final TeamStatus status;

  @override
  List<Object> get props => [team, status];

  TeamState copyWith({Team? team, TeamStatus? status}) {
    return TeamState(team: team ?? this.team, status: status ?? this.status);
  }
}
