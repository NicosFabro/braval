import 'package:calendar_repository/calendar_repository.dart';

class Match extends Event {
  const Match({
    required String id,
    required DateTime? date,
    required this.rival,
    required this.address,
    required this.isLocal,
    required this.lineup,
  }) : super(id: id, date: date);

  final String rival;
  final String address;
  final bool isLocal;
  final List<String> lineup;

  Match copyWith({
    String? id,
    DateTime? date,
    String? rival,
    String? address,
    bool? isLocal,
    List<String>? lineup,
  }) {
    return Match(
      id: id ?? this.id,
      date: date ?? this.date,
      rival: rival ?? this.rival,
      address: address ?? this.address,
      isLocal: isLocal ?? this.isLocal,
      lineup: lineup ?? this.lineup,
    );
  }

  static const empty = Match(
    id: '',
    date: null,
    rival: '',
    address: '',
    isLocal: false,
    lineup: [],
  );

  bool get isEmpty => this == Match.empty;

  bool get isNotEmpty => this != Match.empty;

  MatchEntity toEntity() => MatchEntity(
        id,
        date,
        rival,
        address,
        isLocal,
        lineup,
      );

  static Match fromEntity(MatchEntity entity) => Match(
        id: entity.id,
        date: entity.date,
        rival: entity.rival,
        address: entity.address,
        isLocal: entity.isLocal,
        lineup: entity.lineup,
      );

  @override
  List<Object?> get props => [
        id,
        date,
        rival,
        address,
        isLocal,
        lineup,
      ];
}
