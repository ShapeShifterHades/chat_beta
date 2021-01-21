import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import '../../authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository, this._firestoreNewUserRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final FirestoreNewUserRepository _firestoreNewUserRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.username,
        state.password,
        state.confirmedPassword,
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
        state.username,
        password,
        state.confirmedPassword,
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
        state.username,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    UserCredential credential;
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      credential = await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
          displayName: state.username.value);
      try {
        await _firestoreNewUserRepository.addNewProfile(Profile(
          uid: credential.user.uid,
          username: state.username.value,
          bio: '',
        ));
        // print(
        //     ' credential.credential.providerId: {$credential.credential.providerId}');
        // print(
        //     ' credential.credential.signInMethod: {$credential.credential.signInMethod}');
        // print(' credential.credential.token: {$credential.credential.token}');
        // print(
        //     ' credential.additionalUserInfo.username: {$credential.additionalUserInfo.username}');
        // print(
        //     ' credential.user.metadata.creationTime: {$credential.user.metadata.creationTime}');
        // print(
        //     ' credential.user.metadata.creationTime: {$credential.user.metadata.creationTime}');
        // print(
        //     ' credential.user.metadata.lastSignInTime: {$credential.user.metadata.lastSignInTime}');
      } catch (e) {
        print('Shite happend: {$e}');
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
