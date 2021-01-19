part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Username username;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  @override
  List<Object> get props =>
      [email, username, password, confirmedPassword, status];

  SignUpState copyWith({
    Email email,
    Username username,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}
