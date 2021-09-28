import 'package:equatable/equatable.dart';

class FootballMatchEvents extends Equatable {
  const FootballMatchEvents({required this.braval, required this.rival});

  final FootballBravalStats braval;
  final FootballRivalStats rival;

  FootballMatchEvents copyWith({
    FootballBravalStats? braval,
    FootballRivalStats? rival,
  }) {
    return FootballMatchEvents(
      braval: braval ?? this.braval,
      rival: rival ?? this.rival,
    );
  }

  static const empty = FootballMatchEvents(
    braval: FootballBravalStats.empty,
    rival: FootballRivalStats.empty,
  );

  bool get isEmpty => this == FootballMatchEvents.empty;

  bool get isNotEmpty => this != FootballMatchEvents.empty;

  static const goals = 'goals';
  static const fouls = 'fouls';
  static const yellowCards = 'yellowCards';
  static const redCards = 'redCards';

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

  final List<Map<String, dynamic>> goals;
  final List<Map<String, dynamic>> fouls;
  final List<Map<String, dynamic>> yellowCards;
  final List<Map<String, dynamic>> redCards;

  FootballBravalStats copyWith({
    List<Map<String, dynamic>>? goals,
    List<Map<String, dynamic>>? fouls,
    List<Map<String, dynamic>>? yellowCards,
    List<Map<String, dynamic>>? redCards,
  }) {
    return FootballBravalStats(
      goals: goals ?? this.goals,
      fouls: fouls ?? this.fouls,
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
    );
  }

  static const empty = FootballBravalStats(
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
