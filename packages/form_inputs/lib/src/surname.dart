import 'package:formz/formz.dart';

/// Validation errors for the [Surname] [FormzInput].
enum SurnameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template surname}
/// Form input for an surname input.
/// {@endtemplate}
class Surname extends FormzInput<String, SurnameValidationError> {
  /// {@macro surname}
  const Surname.pure() : super.pure('');

  /// {@macro surname}
  const Surname.dirty([String value = '']) : super.dirty(value);

  @override
  SurnameValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : SurnameValidationError.invalid;
  }
}
