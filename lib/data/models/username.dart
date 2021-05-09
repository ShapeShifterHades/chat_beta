import 'package:formz/formz.dart';

enum UsernameValidationError { invalid, alreadyExist }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernameRegExp = RegExp(
    r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$',
  );

  @override
  UsernameValidationError? validator(String value) {
    // return _UsernameRegExp.hasMatch(value) ? null : UsernameValidationError.invalid;

    if (!_usernameRegExp.hasMatch(value)) {
      return UsernameValidationError.invalid;
    }
    return null;
  }

  static String? getErrorMessage(UsernameValidationError error) {
    switch (error) {
      case UsernameValidationError.invalid:
        return 'This is not a valid Username';
      default:
        return null;
    }
  }
}
