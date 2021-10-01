import 'package:equatable/equatable.dart';
import 'package:team_repository/src/models/models.dart';

class Team extends Equatable {
  const Team({
    required this.id,
    required this.sport,
    required this.category,
    required this.year,
    this.players,
  });

  static const sportFootball = 'football';
  static const sportBasket = 'basket';

  final String id;
  final String sport;
  final String category;
  final String year;
  final List<TeamPlayer>? players;

  Team copyWith({
    String? id,
    String? sport,
    String? category,
    String? year,
    List<TeamPlayer>? players,
  }) {
    return Team(
      id: id ?? this.id,
      sport: sport ?? this.sport,
      category: category ?? this.category,
      year: year ?? this.year,
      players: players ?? this.players,
    );
  }

  static const empty = Team(
    id: '',
    sport: '',
    category: '',
    year: '',
    players: [],
  );

  bool get isEmpty => this == Team.empty;

  bool get isNotEmpty => this != Team.empty;

  TeamEntity toEntity() => TeamEntity(id, sport, category, year);

  static Team fromEntity(TeamEntity entity) => Team(
        id: entity.id,
        sport: entity.sport,
        category: entity.category,
        year: entity.year,
      );

  @override
  List<Object?> get props => [id, sport, category, year];
}
