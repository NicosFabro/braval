part of 'match_cubit.dart';

class MatchState extends Equatable {
  const MatchState({
    required this.date,
    required this.hour,
    required this.rival,
    required this.address,
    required this.isLocal,
    required this.isFinished,
    required this.lineup,
    this.status = FormzStatus.pure,
  });

  final DateTime date;
  final TimeOfDay hour;
  final Rival rival;
  final Address address;
  final bool isLocal;
  final bool isFinished;
  final List<String> lineup;
  final FormzStatus status;

  @override
  List<Object> get props => [
        date,
        hour,
        rival,
        address,
        isLocal,
        isFinished,
        lineup,
        status,
      ];

  MatchState copyWith({
    DateTime? date,
    TimeOfDay? hour,
    Rival? rival,
    Address? address,
    bool? isLocal,
    bool? isFinished,
    List<String>? lineup,
    FormzStatus? status,
  }) {
    return MatchState(
      date: date ?? this.date,
      hour: hour ?? this.hour,
      rival: rival ?? this.rival,
      address: address ?? this.address,
      isLocal: isLocal ?? this.isLocal,
      isFinished: isFinished ?? this.isFinished,
      lineup: lineup ?? this.lineup,
      status: status ?? this.status,
    );
  }
}
