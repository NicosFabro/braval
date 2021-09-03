import 'package:equatable/equatable.dart';
import 'package:team_repository/src/models/models.dart';

class TeamPlayer extends Equatable {
  const TeamPlayer({
    required this.id,
    required this.position,
  });

  final String id;
  final String position;

  TeamPlayer copyWith({
    String? id,
    String? position,
  }) {
    return TeamPlayer(id: id ?? this.id, position: position ?? this.position);
  }

  static const empty = TeamPlayer(id: '', position: '');

  bool get isEmpty => this == TeamPlayer.empty;

  bool get isNotEmpty => this != TeamPlayer.empty;

  TeamPlayerEntity toEntity() => TeamPlayerEntity(id, position);

  static TeamPlayer fromEntity(TeamPlayerEntity entity) => TeamPlayer(
        id: entity.id,
        position: entity.position,
      );

  @override
  List<Object?> get props => [id, position];
}
