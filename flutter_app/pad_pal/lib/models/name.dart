import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  static final RegExp _name = RegExp(
    r'^[A-Za-z ]{2,}$',
  );

  @override
  NameValidationError validator(String value) {
    return _name.hasMatch(value) ? null : NameValidationError.invalid;
  }
}
