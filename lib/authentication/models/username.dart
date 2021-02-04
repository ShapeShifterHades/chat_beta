import 'package:formz/formz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  // Only contains alphanumeric characters, underscore and dot.
  // Underscore and dot can't be at the end or start of a username (e.g _username / username_ / .username / username.).
  // Underscore and dot can't be next to each other (e.g user_.name).
  // Underscore or dot can't be used multiple times in a row (e.g user__name / user..name).
  // Number of characters must be between 6 to 16.
  static final RegExp _usernameRegExp = RegExp(
    r'^(?=[a-zA-Z0-9._]{5,12}$)(?!.*[_.]{2})[^_.].*[^_.]$',
  );

  @override
  UsernameValidationError validator(String value) {
    // if (_usernameRegExp.hasMatch(value)) {
    //   var isGood = await usernameCheck(value);
    //   print(isGood);
    //   return !isGood ? null : UsernameValidationError.invalid;

    // } else {
    //   return UsernameValidationError.invalid;
    // }
    return
     _usernameRegExp.hasMatch(value)
        ? null
        : UsernameValidationError.invalid;
  }

  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('usernames')
        // .where('username', isEqualTo: username)
        .doc(username)
        .get();
    return result.exists;
  }
}
