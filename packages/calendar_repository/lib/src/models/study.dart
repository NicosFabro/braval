import 'package:calendar_repository/calendar_repository.dart';

class Study extends Event {
  const Study({
    required String id,
    required DateTime? date,
  }) : super(id: id, date: date);

  Study copyWith({String? id, DateTime? date}) {
    return Study(id: id ?? this.id, date: date ?? this.date);
  }

  static const empty = Study(id: '', date: null);

  bool get isEmpty => this == Study.empty;

  bool get isNotEmpty => this != Study.empty;

  StudyEntity toEntity() => StudyEntity(id, date);

  static Study fromEntity(StudyEntity entity) => Study(
        id: entity.id,
        date: entity.date,
      );

  @override
  List<Object?> get props => [id, date];
}
