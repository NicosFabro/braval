import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum AddressValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template address}
/// Form input for an address input.
/// {@endtemplate}
class Address extends FormzInput<String, AddressValidationError> {
  /// {@macro address}
  const Address.pure() : super.pure('');

  /// {@macro address}
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : AddressValidationError.invalid;
  }
}
