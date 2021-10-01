import 'package:formz/formz.dart';

/// Validation errors for the [Rival] [FormzInput].
enum RivalValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template rival}
/// Form input for an rival input.
/// {@endtemplate}
class Rival extends FormzInput<String, RivalValidationError> {
  /// {@macro rival}
  const Rival.pure() : super.pure('');

  /// {@macro rival}
  const Rival.dirty([String value = '']) : super.dirty(value);

  @override
  RivalValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : RivalValidationError.invalid;
  }
}
