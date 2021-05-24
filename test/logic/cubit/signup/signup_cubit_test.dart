import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:void_chat_beta/data/models/confirmed_password.dart';
import 'package:void_chat_beta/data/models/email.dart';
import 'package:void_chat_beta/data/models/password.dart';
import 'package:void_chat_beta/data/models/username.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 'theAnswerIs42';
  const validPassword = Password.dirty(validPasswordString);

  const invalidConfirmedPasswordString = 'invalid';
  const invalidConfirmedPassword = ConfirmedPassword.dirty(
    password: validPasswordString,
    value: invalidConfirmedPasswordString,
  );

  const validConfirmedPasswordString = 'theAnswerIs42';
  const validConfirmedPassword = ConfirmedPassword.dirty(
    password: validPasswordString,
    value: validConfirmedPasswordString,
  );

  const invalidUsernameString = 'inv';
  const invalidUsername = Username.dirty(invalidUsernameString);

  const validUsernameString = 'validUser';
  const validUsername = Username.dirty(validUsernameString);

  group('SignupCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(
        () => authenticationRepository
            .signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )
            .then((_) => null),
      );
    });
  });
}
