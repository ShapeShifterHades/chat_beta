import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/data/models/email.dart';
import 'package:void_chat_beta/data/models/password.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');

  group('LoginState', () {
    test('supports value comparisons', () {
      expect(const LoginState(), const LoginState());
    });

    test('returns same object when no properties are passed', () {
      expect(const LoginState().copyWith(), const LoginState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const LoginState().copyWith(status: FormzStatus.pure),
        const LoginState(status: FormzStatus.pure),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        const LoginState().copyWith(email: email),
        const LoginState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const LoginState().copyWith(password: password),
        const LoginState(password: password),
      );
    });
  });
}
