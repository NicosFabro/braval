part of 'event_cubit.dart';

enum EventStatus {
  pure,
  saving,
  success,
  failure,
}

class EventState extends Equatable {
  const EventState({
    required this.type,
    required this.daysSelected,
    required this.dateStart,
    required this.dateEnd,
    required this.hour,
    this.status = EventStatus.pure,
  });

  final EventType type;
  final Map<String, bool> daysSelected;
  final DateTime dateStart;
  final DateTime dateEnd;
  final TimeOfDay hour;
  final EventStatus status;

  @override
  List<Object> get props => [
        daysSelected.values,
        dateStart,
        dateEnd,
        hour,
        status,
      ];

  EventState copyWith({
    Map<String, bool>? daysSelected,
    DateTime? dateStart,
    DateTime? dateEnd,
    TimeOfDay? hour,
    EventStatus? status,
  }) {
    return EventState(
      type: type,
      daysSelected: daysSelected ?? this.daysSelected,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      hour: hour ?? this.hour,
      status: status ?? this.status,
    );
  }
}
