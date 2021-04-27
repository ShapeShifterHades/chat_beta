import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/authentication/models/confirmed_password.dart';
import 'package:void_chat_beta/authentication/models/email.dart';
import 'package:void_chat_beta/authentication/models/password.dart';
import 'package:void_chat_beta/authentication/models/username.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository, this._newUserRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final FirestoreNewUserRepository _newUserRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
        state.username,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword,
        state.username,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
        state.username,
      ]),
    ));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
        username: username,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          username,
        ])));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var _exists =
          await _newUserRepository.usernameAlreadyExists(state.username.value);
      if (_exists) {
        print('WE FUCKED UP!!! username already exists!');
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
    try {
      var userCredential = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      NewProfile newProfile = NewProfile(
          uid: userCredential.user!.uid, username: state.username.value);
      await _newUserRepository.addNewUser(newProfile);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Username username;
  final FormzStatus status;

  @override
  List<Object> get props =>
      [username, email, password, confirmedPassword, status];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Username? username,
    FormzStatus? status,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}
