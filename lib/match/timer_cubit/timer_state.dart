part of 'timer_cubit.dart';

enum TimerStatus {
  ready,
  paused,
  running,
  finished,
}

class TimerState extends Equatable {
  const TimerState({
    this.duration = 0,
    this.status = TimerStatus.ready,
  });

  final int duration;
  final TimerStatus status;

  TimerState copyWith({
    int? duration,
    TimerStatus? status,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }

  String get minutesStr =>
      ((duration / 60) % 60).floor().toString().padLeft(2, '0');

  String get secondsStr => (duration % 60).floor().toString().padLeft(2, '0');

  String get timerStr => '$minutesStr:$secondsStr';

  @override
  List<Object> get props => [duration];
}
