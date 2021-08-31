part of 'profile_bloc.dart';

enum ProfileStatus {
  loading,
  success,
  failure,
}

class ProfileState extends Equatable {
  const ProfileState({
    this.profile = Profile.empty,
    this.status = ProfileStatus.loading,
    this.teamPlayersProfiles = const [],
  });

  final Profile profile;
  final ProfileStatus status;
  final List<Profile> teamPlayersProfiles;

  ProfileState copyWith({
    Profile? profile,
    ProfileStatus? status,
    List<Profile>? teamPlayersProfiles,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      teamPlayersProfiles: teamPlayersProfiles ?? this.teamPlayersProfiles,
    );
  }

  @override
  List<Object> get props => [profile, status, teamPlayersProfiles];
}
