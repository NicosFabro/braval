import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FootballMatchEventsEntity extends Equatable {
  const FootballMatchEventsEntity(this.braval, this.rival);

  final FootballBravalStatsEntity braval;
  final FootballRivalStatsEntity rival;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'braval': braval,
        'rival': rival,
      };

  static FootballMatchEventsEntity fromJson(Map<String, dynamic> json) {
    return FootballMatchEventsEntity(
      FootballBravalStatsEntity.fromJson(
        json['braval'] as Map<String, dynamic>,
      ),
      FootballRivalStatsEntity.fromJson(
        json['rival'] as Map<String, dynamic>,
      ),
    );
  }

  static FootballMatchEventsEntity fromSnapshot(DocumentSnapshot snap) {
    return FootballMatchEventsEntity(
      FootballBravalStatsEntity.fromSnapshot(
        snap.get('braval') as DocumentSnapshot,
      ),
      FootballRivalStatsEntity.fromSnapshot(
        snap.get('rival') as DocumentSnapshot,
      ),
    );
  }

  @override
  List<Object?> get props => [braval, rival];
}

class FootballBravalStatsEntity extends Equatable {
  const FootballBravalStatsEntity(
    this.goals,
    this.fouls,
    this.yellowCards,
    this.redCards,
  );

  final List<Map<String, dynamic>> goals;
  final List<Map<String, dynamic>> fouls;
  final List<Map<String, dynamic>> yellowCards;
  final List<Map<String, dynamic>> redCards;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'goals': goals,
        'fouls': fouls,
        'yellowCards': yellowCards,
        'redCards': redCards,
      };

  static FootballBravalStatsEntity fromJson(Map<String, dynamic> json) {
    return FootballBravalStatsEntity(
      json['goals'] as List<Map<String, dynamic>>,
      json['fouls'] as List<Map<String, dynamic>>,
      json['yellowCards'] as List<Map<String, dynamic>>,
      json['redCards'] as List<Map<String, dynamic>>,
    );
  }

  static FootballBravalStatsEntity fromSnapshot(DocumentSnapshot snap) {
    return FootballBravalStatsEntity(
      snap.get('goals') as List<Map<String, dynamic>>,
      snap.get('fouls') as List<Map<String, dynamic>>,
      snap.get('yellowCards') as List<Map<String, dynamic>>,
      snap.get('redCards') as List<Map<String, dynamic>>,
    );
  }

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'goals': goals,
        'fouls': fouls,
        'yellowCards': yellowCards,
        'redCards': redCards,
      };

  @override
  List<Object?> get props => [
        goals,
        fouls,
        yellowCards,
        redCards,
      ];
}

class FootballRivalStatsEntity extends Equatable {
  const FootballRivalStatsEntity(
    this.goals,
    this.fouls,
    this.yellowCards,
    this.redCards,
  );

  final List<int> goals;
  final List<int> fouls;
  final List<int> yellowCards;
  final List<int> redCards;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'goals': goals,
        'fouls': fouls,
        'yellowCards': yellowCards,
        'redCards': redCards,
      };

  static FootballRivalStatsEntity fromJson(Map<String, dynamic> json) {
    return FootballRivalStatsEntity(
      json['goals'] as List<int>,
      json['fouls'] as List<int>,
      json['yellowCards'] as List<int>,
      json['redCards'] as List<int>,
    );
  }

  static FootballRivalStatsEntity fromSnapshot(DocumentSnapshot snap) {
    return FootballRivalStatsEntity(
      (snap.get('goals') as List<dynamic>).cast<int>(),
      (snap.get('fouls') as List<dynamic>).cast<int>(),
      (snap.get('yellowCards') as List<dynamic>).cast<int>(),
      (snap.get('redCards') as List<dynamic>).cast<int>(),
    );
  }

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'goals': goals,
        'fouls': fouls,
        'yellowCards': yellowCards,
        'redCards': redCards,
      };

  @override
  List<Object?> get props => [
        goals,
        fouls,
        yellowCards,
        redCards,
      ];
}
