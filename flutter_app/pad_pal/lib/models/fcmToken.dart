import 'package:formz/formz.dart';

enum FcmTokenValidationError { invalid }

class FcmToken extends FormzInput<String, FcmTokenValidationError> {
  const FcmToken.pure() : super.pure('');
  const FcmToken.dirty([String value = '']) : super.dirty(value);

  static final RegExp _RegExp = RegExp(
    r'^[\s\S]{2,}$',
  );
  @override
  FcmTokenValidationError validator(String value) {
    return _RegExp.hasMatch(value) ? null : FcmTokenValidationError.invalid;
  }
}
