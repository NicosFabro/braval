import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TeamPlayerEntity extends Equatable {
  const TeamPlayerEntity(
    this.id,
    this.position,
    this.schoolYear,
    this.backNumber,
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

  final String id;
  final String position;
  final String schoolYear;
  final int backNumber;
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
        'id': id,
        'position': position,
        'schoolYear': schoolYear,
        'backNumber': backNumber,
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

  static TeamPlayerEntity fromJson(Map<String, dynamic> json) =>
      TeamPlayerEntity(
        json['id'] as String,
        json['position'] as String,
        json['schoolYear'] as String,
        json['backNumber'] as int,
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

  static TeamPlayerEntity fromSnapshot(DocumentSnapshot snap) {
    final evaluationStudyType = snap.get('evaluationStudy').runtimeType;
    final evaluationMatchType = snap.get('evaluationMatch').runtimeType;
    return TeamPlayerEntity(
      snap.get('id') as String,
      snap.get('position') as String,
      snap.get('schoolYear') as String,
      snap.get('backNumber') as int,
      snap.get('assistanceStudy') as int,
      snap.get('assistanceMeeting') as int,
      snap.get('assistanceTraining') as int,
      snap.get('assistanceMatch') as int,
      evaluationStudyType == double
          ? snap.get('evaluationStudy') as double
          : (snap.get('evaluationStudy') as int).toDouble(),
      evaluationMatchType == double
          ? snap.get('evaluationMatch') as double
          : (snap.get('evaluationMatch') as int).toDouble(),
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
        'id': id,
        'position': position,
        'schoolYear': schoolYear,
        'backNumber': backNumber,
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
        id,
        position,
        schoolYear,
        backNumber,
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
