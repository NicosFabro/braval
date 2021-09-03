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

class TeamPlayersProfilesFetchRequested extends ProfileEvent {
  const TeamPlayersProfilesFetchRequested(this.playerIds);
  final List<String> playerIds;

  @override
  List<Object> get props => [playerIds];
}
