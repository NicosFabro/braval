import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository}) : super(const ProfileState());

  final ProfileRepository profileRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileFetchRequested) {
      yield* _mapProfileFetchRequestedToState(event);
    } else if (event is TeamPlayersProfilesFetchRequested) {
      yield* _mapProfilesFetchRequestedToState(event);
    }
  }

  Stream<ProfileState> _mapProfileFetchRequestedToState(
    ProfileFetchRequested event,
  ) async* {
    yield state.copyWith(status: ProfileStatus.loading);
    try {
      final profile = await profileRepository.getProfileById(event.userId);
      yield state.copyWith(profile: profile, status: ProfileStatus.success);
    } catch (_) {
      yield state.copyWith(status: ProfileStatus.failure);
    }
  }

  Stream<ProfileState> _mapProfilesFetchRequestedToState(
    TeamPlayersProfilesFetchRequested event,
  ) async* {
    yield state.copyWith(status: ProfileStatus.loading);
    try {
      final profiles =
          await profileRepository.getProfilesByListOfIds(event.playerIds);
      yield state.copyWith(
        teamPlayersProfiles: profiles,
        status: ProfileStatus.success,
      );
    } on Exception catch (e) {
      log(e.toString());
      yield state.copyWith(status: ProfileStatus.failure);
    }
  }
}
