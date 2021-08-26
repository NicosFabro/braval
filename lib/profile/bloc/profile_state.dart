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
  });

  final Profile profile;
  final ProfileStatus status;

  ProfileState copyWith({
    Profile? profile,
    ProfileStatus? status,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [profile, status];
}
