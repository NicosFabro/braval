part of 'splash_screen_bloc.dart';

enum SplashScreenStatus { loading, loaded }

class SplashScreenState extends Equatable {
  const SplashScreenState({this.status = SplashScreenStatus.loading});

  final SplashScreenStatus status;

  SplashScreenState copyWith({SplashScreenStatus? status}) {
    return SplashScreenState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
