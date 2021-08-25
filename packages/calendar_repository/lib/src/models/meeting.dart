import 'package:calendar_repository/calendar_repository.dart';

class Meeting extends Event {
  const Meeting({
    required String id,
    required DateTime? date,
  }) : super(id: id, date: date);

  Meeting copyWith({String? id, DateTime? date}) {
    return Meeting(id: id ?? this.id, date: date ?? this.date);
  }

  static const empty = Meeting(id: '', date: null);

  @override
  bool get isEmpty => this == Meeting.empty;

  @override
  bool get isNotEmpty => this != Meeting.empty;

  MeetingEntity toEntity() => MeetingEntity(id, date);

  static Meeting fromEntity(MeetingEntity entity) => Meeting(
        id: entity.id,
        date: entity.date,
      );

  @override
  List<Object?> get props => [id, date];
}
