import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(const SplashScreenState());

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is SplashScreenRequested) {
      yield* _mapSplashScreenRequested(event);
    }
  }

  Stream<SplashScreenState> _mapSplashScreenRequested(
    SplashScreenRequested event,
  ) async* {
    yield state.copyWith(status: SplashScreenStatus.loading);
    await Future<void>.delayed(const Duration(seconds: 2));
    yield state.copyWith(status: SplashScreenStatus.loaded);
  }
}
