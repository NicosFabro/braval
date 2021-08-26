import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.id,
    required this.date,
  });

  final String id;
  final DateTime? date;

  static const empty = Event(id: '', date: null);

  bool get isEmpty => this == Event.empty;

  bool get isNotEmpty => this != Event.empty;

  @override
  List<Object?> get props => [id, date];

  Event copyWith({String? id, DateTime? date}) {
    return Event(id: id ?? this.id, date: date ?? this.date);
  }
}
