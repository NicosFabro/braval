import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState());

  late Timer timer;

  void startTimer({int startAtSecond = 0}) {
    emit(state.copyWith(duration: startAtSecond));
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        emit(
          state.copyWith(
            duration: state.duration + 1,
            status: TimerStatus.running,
          ),
        );
      },
    );
  }

  void stopTimer() {
    emit(state.copyWith(status: TimerStatus.paused));
    if (timer.isActive) {
      timer.cancel();
    }
  }

  void finishTimer() {
    emit(state.copyWith(status: TimerStatus.finished));
    if (timer.isActive) {
      timer.cancel();
    }
  }
}
