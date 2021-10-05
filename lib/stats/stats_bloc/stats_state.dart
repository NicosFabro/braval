part of 'stats_bloc.dart';

enum StatsStatus {
  loading,
  success,
  failure,
}

class StatsState extends Equatable {
  const StatsState({
    this.stats = const [],
    this.status = StatsStatus.loading,
  });

  final List<PlayerStats> stats;
  final StatsStatus status;

  StatsState copyWith({
    List<PlayerStats>? stats,
    StatsStatus? status,
  }) {
    return StatsState(
      stats: stats ?? this.stats,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [stats, status];
}
