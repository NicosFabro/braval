import 'package:equatable/equatable.dart';
import 'package:team_repository/src/models/models.dart';

class TeamPlayer extends Equatable {
  const TeamPlayer({
    required this.id,
    required this.position,
    required this.schoolYear,
    required this.assistanceStudy,
    required this.assistanceMeeting,
    required this.assistanceTraining,
    required this.assistanceMatch,
    required this.evaluationStudy,
    required this.evaluationMatch,
    required this.goals,
    required this.freeShot,
    required this.shot,
    required this.triple,
    required this.fouls,
    required this.yellowCards,
    required this.redCards,
  });

  final String id;
  final String position;
  final String schoolYear;
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

  TeamPlayer copyWith({
    String? id,
    String? position,
    String? schoolYear,
    int? assistanceStudy,
    int? assistanceMeeting,
    int? assistanceTraining,
    int? assistanceMatch,
    double? evaluationStudy,
    double? evaluationMatch,
    int? goals,
    int? freeShot,
    int? shot,
    int? triple,
    int? fouls,
    int? yellowCards,
    int? redCards,
  }) {
    return TeamPlayer(
      id: id ?? this.id,
      position: position ?? this.position,
      schoolYear: schoolYear ?? this.schoolYear,
      assistanceStudy: assistanceStudy ?? this.assistanceStudy,
      assistanceMeeting: assistanceMeeting ?? this.assistanceMeeting,
      assistanceTraining: assistanceTraining ?? this.assistanceTraining,
      assistanceMatch: assistanceMatch ?? this.assistanceMatch,
      evaluationStudy: evaluationStudy ?? this.evaluationStudy,
      evaluationMatch: evaluationMatch ?? this.evaluationMatch,
      goals: goals ?? this.goals,
      freeShot: freeShot ?? this.freeShot,
      shot: shot ?? this.shot,
      triple: triple ?? this.triple,
      fouls: fouls ?? this.fouls,
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
    );
  }

  static const empty = TeamPlayer(
    id: '',
    position: '',
    schoolYear: '',
    assistanceStudy: 0,
    assistanceMeeting: 0,
    assistanceTraining: 0,
    assistanceMatch: 0,
    evaluationStudy: 0,
    evaluationMatch: 0,
    goals: 0,
    freeShot: 0,
    shot: 0,
    triple: 0,
    fouls: 0,
    yellowCards: 0,
    redCards: 0,
  );

  bool get isEmpty => this == TeamPlayer.empty;

  bool get isNotEmpty => this != TeamPlayer.empty;

  TeamPlayerEntity toEntity() => TeamPlayerEntity(
        id,
        position,
        schoolYear,
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
      );

  static TeamPlayer fromEntity(TeamPlayerEntity entity) => TeamPlayer(
        id: entity.id,
        position: entity.position,
        schoolYear: entity.schoolYear,
        assistanceStudy: entity.assistanceStudy,
        assistanceMeeting: entity.assistanceMeeting,
        assistanceTraining: entity.assistanceTraining,
        assistanceMatch: entity.assistanceMatch,
        evaluationStudy: entity.evaluationStudy,
        evaluationMatch: entity.evaluationMatch,
        goals: entity.goals,
        freeShot: entity.freeShot,
        shot: entity.shot,
        triple: entity.triple,
        fouls: entity.fouls,
        yellowCards: entity.yellowCards,
        redCards: entity.redCards,
      );

  @override
  List<Object?> get props => [
        id,
        position,
        schoolYear,
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
