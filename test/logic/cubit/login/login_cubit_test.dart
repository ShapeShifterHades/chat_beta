import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:void_chat_beta/data/models/email.dart';
import 'package:void_chat_beta/data/models/password.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

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

  group('LoginCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();

      when(
        () => authenticationRepository.logInWithGoogle(),
        // ignore: avoid_returning_null_for_void
      ).thenAnswer((_) async => null);
      when(
        () => authenticationRepository.logInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
        // ignore: avoid_returning_null_for_void
      ).thenAnswer((_) async => null);
    });
    test('initial state is LoginState', () {
      expect(LoginCubit(authenticationRepository).state, const LoginState());
    });
    group('email changed', () {
      blocTest<LoginCubit, LoginState>(
        'emits [invalid] when email/password are invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.emailChanged(invalidEmailString),
        expect: () => const <LoginState>[
          LoginState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [valid] when email/password are valid',
        build: () => LoginCubit(authenticationRepository),
        seed: () => const LoginState(password: validPassword),
        act: (bloc) => bloc.emailChanged(validEmailString),
        expect: () => const <LoginState>[
          LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('passwordChanged', () {
      blocTest<LoginCubit, LoginState>(
        'emits [invalid] when email/password are invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.passwordChanged(invalidPasswordString),
        expect: () => const <LoginState>[
          LoginState(password: invalidPassword, status: FormzStatus.invalid),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [valid] when email/password are valid',
        build: () => LoginCubit(authenticationRepository),
        seed: () => const LoginState(email: validEmail),
        act: (bloc) => bloc.passwordChanged(validPasswordString),
        expect: () => const <LoginState>[
          LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('loginWithCredentials', () {
      blocTest<LoginCubit, LoginState>(
        'does nothing when status is FormzStatus.invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.logInWithCredentials(),
        expect: () => const <LoginState>[],
      );

      blocTest<LoginCubit, LoginState>(
          'calls logInWithEmailAndPassword with correct email/password',
          build: () => LoginCubit(authenticationRepository),
          seed: () => const LoginState(
                status: FormzStatus.valid,
                email: validEmail,
                password: validPassword,
              ),
          act: (bloc) => bloc.logInWithCredentials(),
          verify: (_) {
            verify(() => authenticationRepository.logInWithEmailAndPassword(
                  email: validEmailString,
                  password: validPasswordString,
                )).called(1);
          });

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionSuccess] when loginWithEmailAndPassword succeeds',
        build: () => LoginCubit(authenticationRepository),
        seed: () => const LoginState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (bloc) => bloc.logInWithCredentials(),
        expect: () => const <LoginState>[
          LoginState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
          ),
          LoginState(
            status: FormzStatus.submissionSuccess,
            email: validEmail,
            password: validPassword,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionFailure] when loginWithEmailAndPassword succeeds',
        build: () {
          when(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('failed'));
          return LoginCubit(authenticationRepository);
        },
        seed: () => const LoginState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (bloc) => bloc.logInWithCredentials(),
        expect: () => const <LoginState>[
          LoginState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
          ),
          LoginState(
            status: FormzStatus.submissionFailure,
            email: validEmail,
            password: validPassword,
          ),
        ],
      );
    });

    group('loginWithGoogle', () {
      blocTest<LoginCubit, LoginState>('calls loginWithGoogle',
          build: () => LoginCubit(authenticationRepository),
          act: (bloc) => bloc.logInWithGoogle(),
          verify: (_) {
            verify(() => authenticationRepository.logInWithGoogle()).called(1);
          });

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionSuccess] when logInWithGoogle succeeds',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(status: FormzStatus.submissionInProgress),
          LoginState(status: FormzStatus.submissionSuccess),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionFailure] when logInWithGoogle fails',
        build: () {
          when(
            () => authenticationRepository.logInWithGoogle(),
          ).thenThrow(Exception('failure'));
          return LoginCubit(authenticationRepository);
        },
        act: (bloc) => bloc.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(status: FormzStatus.submissionInProgress),
          LoginState(status: FormzStatus.submissionFailure),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, pure] when logInWithGoogle is cancelled',
        build: () {
          when(() => authenticationRepository.logInWithGoogle()).thenThrow(
            NoSuchMethodError.withInvocation(
              null,
              Invocation.getter(#logInWithGoogle),
            ),
          );
          return LoginCubit(authenticationRepository);
        },
        act: (bloc) => bloc.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(status: FormzStatus.submissionInProgress),
          LoginState(),
        ],
      );
    });
  });
}
