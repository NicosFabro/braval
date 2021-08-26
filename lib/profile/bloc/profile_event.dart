part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetchRequested extends ProfileEvent {
  const ProfileFetchRequested(this.userId);
  final String userId;

  @override
  List<Object> get props => [userId];
}
