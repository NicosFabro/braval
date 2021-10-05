import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PlayerStatsEntity extends Equatable {
  const PlayerStatsEntity(
    this.playerId,
    this.assistanceStudy,
    this.assistanceMeeting,
    this.assistanceTraining,
    this.assistanceMatch,
    this.evaluationStudy,
    this.evaluationMatch,
    this.goals,
    this.freeShot,
    this.shot,
    this.triple,
    this.fouls,
    this.yellowCards,
    this.redCards,
  );

  final String playerId;
  final int assistanceStudy;
  final int assistanceMeeting;
  final int assistanceTraining;
  final int assistanceMatch;
  final double evaluationStudy;
  final double evaluationMatch;
  final int goals;
  final int freeShot;
  final int shot;
  final int triple;
  final int fouls;
  final int yellowCards;
  final int redCards;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'playerId': playerId,
        'assistanceStudy': assistanceStudy,
        'assistanceMeeting': assistanceMeeting,
        'assistanceTraining': assistanceTraining,
        'assistanceMatch': assistanceMatch,
        'evaluationStudy': evaluationStudy,
        'evaluationMatch': evaluationMatch,
        'goals': goals,
        'freeShot': freeShot,
        'shot': shot,
        'triple': triple,
        'fouls': fouls,
        'yellowCards': yellowCards,
        'redCards': redCards,
      };

  static PlayerStatsEntity fromJson(Map<String, dynamic> json) {
    return PlayerStatsEntity(
      json['playerId'] as String,
      json['assistanceStudy'] as int,
      json['assistanceMeeting'] as int,
      json['assistanceTraining'] as int,
      json['assistanceMatch'] as int,
      json['evaluationStudy'] as double,
      json['evaluationMatch'] as double,
      json['goals'] as int,
      json['freeShot'] as int,
      json['shot'] as int,
      json['triple'] as int,
      json['fouls'] as int,
      json['yellowCards'] as int,
      json['redCards'] as int,
    );
  }

  static PlayerStatsEntity fromSnapshot(DocumentSnapshot snap) {
    return PlayerStatsEntity(
      snap.get('playerId') as String,
      snap.get('assistanceStudy') as int,
      snap.get('assistanceMeeting') as int,
      snap.get('assistanceTraining') as int,
      snap.get('assistanceMatch') as int,
      snap.get('evaluationStudy') as double,
      snap.get('evaluationMatch') as double,
      snap.get('goals') as int,
      snap.get('freeShot') as int,
      snap.get('shot') as int,
      snap.get('triple') as int,
      snap.get('fouls') as int,
      snap.get('yellowCards') as int,
      snap.get('redCards') as int,
    );
  }

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'playerId': playerId,
        'assistanceStudy': assistanceStudy,
        'assistanceMeeting': assistanceMeeting,
        'assistanceTraining': assistanceTraining,
        'assistanceMatch': assistanceMatch,
        'evaluationStudy': evaluationStudy,
        'evaluationMatch': evaluationMatch,
        'goals': goals,
        'freeShot': freeShot,
        'shot': shot,
        'triple': triple,
        'fouls': fouls,
        'yellowCards': yellowCards,
        'redCards': redCards,
      };

  @override
  List<Object?> get props => [
        playerId,
        assistanceStudy,
        assistanceMeeting,
        assistanceTraining,
        assistanceMatch,
        evaluationStudy,
        evaluationMatch,
        goals,
        freeShot,
        shot,
        triple,
        fouls,
        yellowCards,
        redCards,
      ];
}
