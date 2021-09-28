part of 'match_bloc.dart';

enum MatchStatus {
  notStarted,
  first,
  finishedFirst,
  second,
  finishedSecond,
  third,
  finishedThird,
  fourth,
  finished,
}

class MatchState extends Equatable {
  const MatchState({
    required this.matchSport,
    this.footballMatchEvents = FootballMatchEvents.empty,
    this.basketMatchEvents = BasketMatchEvents.empty,
    this.status = MatchStatus.notStarted,
  });

  final String matchSport;
  final FootballMatchEvents footballMatchEvents;
  final BasketMatchEvents basketMatchEvents;
  final MatchStatus status;

  MatchState copyWith({
    FootballMatchEvents? footballMatchEvents,
    BasketMatchEvents? basketMatchEvents,
    MatchStatus? status,
  }) {
    return MatchState(
      matchSport: matchSport,
      footballMatchEvents: footballMatchEvents ?? this.footballMatchEvents,
      basketMatchEvents: basketMatchEvents ?? this.basketMatchEvents,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        matchSport,
        footballMatchEvents,
        basketMatchEvents,
        status,
      ];
}
