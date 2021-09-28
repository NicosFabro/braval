import 'package:equatable/equatable.dart';

class BasketMatchEvents extends Equatable {
  const BasketMatchEvents({required this.braval, required this.rival});

  final BasketBravalStats braval;
  final BasketRivalStats rival;

  static const empty = BasketMatchEvents(
    braval: BasketBravalStats.empty,
    rival: BasketRivalStats.empty,
  );

  bool get isEmpty => this == BasketMatchEvents.empty;

  bool get isNotEmpty => this != BasketMatchEvents.empty;

  @override
  List<Object?> get props => [braval, rival];
}

class BasketBravalStats extends Equatable {
  const BasketBravalStats({
    required this.freeShot,
    required this.shot,
    required this.triple,
    required this.fouls,
  });

  final Map<String, dynamic> freeShot;
  final Map<String, dynamic> shot;
  final Map<String, dynamic> triple;
  final Map<String, dynamic> fouls;

  BasketBravalStats copyWith({
    Map<String, dynamic>? freeShot,
    Map<String, dynamic>? shot,
    Map<String, dynamic>? triple,
    Map<String, dynamic>? fouls,
  }) {
    return BasketBravalStats(
      freeShot: freeShot ?? this.freeShot,
      shot: shot ?? this.shot,
      triple: triple ?? this.triple,
      fouls: fouls ?? this.fouls,
    );
  }

  static const empty = BasketBravalStats(
    freeShot: <String, dynamic>{},
    shot: <String, dynamic>{},
    triple: <String, dynamic>{},
    fouls: <String, dynamic>{},
  );

  bool get isEmpty => this == BasketBravalStats.empty;

  bool get isNotEmpty => this != BasketBravalStats.empty;

  @override
  List<Object?> get props => [
        freeShot,
        shot,
        triple,
        fouls,
      ];
}

class BasketRivalStats extends Equatable {
  const BasketRivalStats({
    required this.freeShot,
    required this.shot,
    required this.triple,
    required this.fouls,
  });

  final List<int> freeShot;
  final List<int> shot;
  final List<int> triple;
  final List<int> fouls;

  BasketRivalStats copyWith({
    List<int>? freeShot,
    List<int>? shot,
    List<int>? triple,
    List<int>? fouls,
  }) {
    return BasketRivalStats(
      freeShot: freeShot ?? this.freeShot,
      shot: shot ?? this.shot,
      triple: triple ?? this.triple,
      fouls: fouls ?? this.fouls,
    );
  }

  static const empty = BasketRivalStats(
    freeShot: [],
    shot: [],
    triple: [],
    fouls: [],
  );

  bool get isEmpty => this == BasketBravalStats.empty;

  bool get isNotEmpty => this != BasketBravalStats.empty;

  @override
  List<Object?> get props => [
        freeShot,
        shot,
        triple,
        fouls,
      ];
}
