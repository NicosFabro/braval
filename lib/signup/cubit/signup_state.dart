part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.surname = const Surname.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Name name;
  final Surname surname;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  @override
  List<Object> get props => [
        email,
        name,
        surname,
        password,
        confirmedPassword,
        status,
      ];

  SignUpState copyWith({
    Email? email,
    Name? name,
    Surname? surname,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}
