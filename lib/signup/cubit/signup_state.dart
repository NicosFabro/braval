part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.surname = const Surname.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.sport = 'football',
    this.team = 'juv',
    this.role = 'coach',
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Name name;
  final Surname surname;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final String sport;
  final String team;
  final String role;
  final FormzStatus status;

  @override
  List<Object> get props => [
        email,
        name,
        surname,
        password,
        confirmedPassword,
        sport,
        team,
        role,
        status,
      ];

  SignUpState copyWith({
    Email? email,
    Name? name,
    Surname? surname,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    String? sport,
    String? team,
    String? role,
    FormzStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      sport: sport ?? this.sport,
      team: team ?? this.team,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }
}
