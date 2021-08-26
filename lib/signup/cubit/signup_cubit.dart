import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// Packages
import 'package:form_inputs/form_inputs.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:team_repository/team_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this._authenticationRepository,
    this._profileRepository,
    this._teamRepository,
  ) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final ProfileRepository _profileRepository;
  final TeamRepository _teamRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.name,
        state.surname,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.surname,
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void surnameChanged(String value) {
    final surname = Surname.dirty(value);
    emit(state.copyWith(
      surname: surname,
      status: Formz.validate([
        state.email,
        state.name,
        surname,
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.name,
        state.surname,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.name,
        state.surname,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  void sportChanged(String? value) {
    if (value == null) return;
    emit(state.copyWith(
      sport: value,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void teamChanged(String? value) {
    if (value == null) return;
    emit(state.copyWith(
      team: value,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void roleChanged(String? value) {
    if (value == null) return;
    emit(state.copyWith(
      role: value,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final userCredentials = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      final teamId = getTeamId();
      final profile = Profile(
        id: userCredentials.user!.uid,
        name: state.name.value,
        surname: state.surname.value,
        email: state.email.value,
        birthday: null,
        dateCreated: DateTime.now(),
        currentTeam: teamId,
        teamHistory: [teamId],
        avatarURL: '',
        achievements: const [],
      );
      await _profileRepository.createProfile(profile);
      await _teamRepository.addVolunteer(
        teamId,
        userCredentials.user!.uid,
        state.role,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  String getTeamId() {
    final sport = state.sport == 'football' ? 'f' : 'b';
    return '$sport-${state.team}-21_22';
  }
}
