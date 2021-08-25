part of 'meeting_bloc.dart';

enum MeetingStatus {
  loading,
  success,
  failure,
}

class MeetingState extends Equatable {
  const MeetingState({
    this.meetings = const [],
    this.status = MeetingStatus.loading,
  });

  final List<Meeting> meetings;
  final MeetingStatus status;

  MeetingState copyWith({
    List<Meeting>? meetings,
    MeetingStatus? status,
  }) {
    return MeetingState(
      meetings: meetings ?? this.meetings,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [meetings, status];
}
