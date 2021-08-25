import 'package:calendar_repository/calendar_repository.dart';

class Training extends Event {
  const Training({
    required String id,
    required DateTime? date,
  }) : super(id: id, date: date);

  Training copyWith({String? id, DateTime? date}) {
    return Training(id: id ?? this.id, date: date ?? this.date);
  }

  static const empty = Training(id: '', date: null);

  @override
  bool get isEmpty => this == Training.empty;

  @override
  bool get isNotEmpty => this != Training.empty;

  TrainingEntity toEntity() => TrainingEntity(id, date);

  static Training fromEntity(TrainingEntity entity) => Training(
        id: entity.id,
        date: entity.date,
      );

  @override
  List<Object?> get props => [id, date];
}
