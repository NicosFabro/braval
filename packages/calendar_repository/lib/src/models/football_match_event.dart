import 'package:equatable/equatable.dart';

class FootballMatchEvents extends Equatable {
  const FootballMatchEvents({required this.braval, required this.rival});

  final FootballBravalStats braval;
  final FootballRivalStats rival;

  static const empty = FootballMatchEvents(
    braval: FootballBravalStats.empty,
    rival: FootballRivalStats.empty,
  );

  bool get isEmpty => this == FootballMatchEvents.empty;

  bool get isNotEmpty => this != FootballMatchEvents.empty;

  @override
  List<Object?> get props => [braval, rival];
}

class FootballBravalStats extends Equatable {
  const FootballBravalStats({
    required this.goals,
    required this.fouls,
    required this.yellowCards,
    required this.redCards,
  });

  final Map<String, dynamic> goals;
  final Map<String, dynamic> fouls;
  final Map<String, dynamic> yellowCards;
  final Map<String, dynamic> redCards;

  FootballBravalStats copyWith({
    Map<String, dynamic>? goals,
    Map<String, dynamic>? fouls,
    Map<String, dynamic>? yellowCards,
    Map<String, dynamic>? redCards,
  }) {
    return FootballBravalStats(
      goals: goals ?? this.goals,
      fouls: fouls ?? this.fouls,
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
    );
  }

  static const empty = FootballBravalStats(
    goals: <String, dynamic>{},
    fouls: <String, dynamic>{},
    yellowCards: <String, dynamic>{},
    redCards: <String, dynamic>{},
  );

  bool get isEmpty => this == FootballBravalStats.empty;

  bool get isNotEmpty => this != FootballBravalStats.empty;

  @override
  List<Object?> get props => [
        goals,
        fouls,
        yellowCards,
        redCards,
      ];
}

class FootballRivalStats extends Equatable {
  const FootballRivalStats({
    required this.goals,
    required this.fouls,
    required this.yellowCards,
    required this.redCards,
  });

  final List<int> goals;
  final List<int> fouls;
  final List<int> yellowCards;
  final List<int> redCards;

  FootballRivalStats copyWith({
    List<int>? goals,
    List<int>? fouls,
    List<int>? yellowCards,
    List<int>? redCards,
  }) {
    return FootballRivalStats(
      goals: goals ?? this.goals,
      fouls: fouls ?? this.fouls,
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
    );
  }

  static const empty = FootballRivalStats(
    goals: [],
    fouls: [],
    yellowCards: [],
    redCards: [],
  );

  bool get isEmpty => this == FootballBravalStats.empty;

  bool get isNotEmpty => this != FootballBravalStats.empty;

  @override
  List<Object?> get props => [
        goals,
        fouls,
        yellowCards,
        redCards,
      ];
}
