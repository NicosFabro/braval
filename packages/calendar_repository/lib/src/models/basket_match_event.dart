import 'package:equatable/equatable.dart';

class BasketMatchEvents extends Equatable {
  const BasketMatchEvents({required this.braval, required this.rival});

  final BasketBravalStats braval;
  final BasketRivalStats rival;

  static const empty = BasketMatchEvents(
    braval: BasketBravalStats.empty,
    rival: BasketRivalStats.empty,
  );

  BasketMatchEvents copyWith({
    BasketBravalStats? braval,
    BasketRivalStats? rival,
  }) {
    return BasketMatchEvents(
      braval: braval ?? this.braval,
      rival: rival ?? this.rival,
    );
  }

  bool get isEmpty => this == BasketMatchEvents.empty;

  bool get isNotEmpty => this != BasketMatchEvents.empty;

  static const freeShot = 'freeShot';
  static const shot = 'shot';
  static const triple = 'triple';
  static const fouls = 'fouls';

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

  final List<Map<String, dynamic>> freeShot;
  final List<Map<String, dynamic>> shot;
  final List<Map<String, dynamic>> triple;
  final List<Map<String, dynamic>> fouls;

  BasketBravalStats copyWith({
    List<Map<String, dynamic>>? freeShot,
    List<Map<String, dynamic>>? shot,
    List<Map<String, dynamic>>? triple,
    List<Map<String, dynamic>>? fouls,
  }) {
    return BasketBravalStats(
      freeShot: freeShot ?? this.freeShot,
      shot: shot ?? this.shot,
      triple: triple ?? this.triple,
      fouls: fouls ?? this.fouls,
    );
  }

  static const empty = BasketBravalStats(
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
