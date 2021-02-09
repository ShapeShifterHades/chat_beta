import 'package:get/get.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpFormBloc extends FormBloc<String, String> {
  final AuthenticationRepository _authenticationRepository;

  final FirestoreNewUserRepository _firestoreNewUserRepository;

  // ignore: close_sinks
  final email = TextFieldBloc(name: 'Email field', validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.email,
  ]);

  // ignore: close_sinks
  final password = TextFieldBloc(name: 'Password', validators: [
    FieldBlocValidators.passwordMin6Chars,
    FieldBlocValidators.required,
  ]);

  final confirmPassword = TextFieldBloc(name: 'Confirm passwords', validators: [
    FieldBlocValidators.required,
  ]);

  // ignore: close_sinks
  final username = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime: Duration(milliseconds: 500),
  );

  // ignore: close_sinks
  final showAgreementCheckbox = BooleanFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  SignUpFormBloc(
      this._authenticationRepository, this._firestoreNewUserRepository) {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
        confirmPassword,
        username,
        showAgreementCheckbox,
      ],
    );
    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
    username.addAsyncValidators([_checkUsername]);
  }

  // ignore: unused_element
  // ignore: missing_return
  Future<String> _signUpFormSubmitted() async {
    UserCredential credential;
    emitLoading();
    try {
      credential = await _authenticationRepository.signUp(
        email: email.value,
        password: password.value,
      );
      try {
        await _firestoreNewUserRepository.addNewUser(NewProfile(
          uid: credential.user.uid,
          username: username.value,
        ));
        emitSuccess();
      } catch (e) {
        print(e);
        emitFailure();
      }
    } catch (e) {
      print(e);
      emitFailure();
    }
  }

  /// Checks Firestore username collection wether [username] exists, blocks validation if it does.
  Future<String> _checkUsername(String username) async {
    var usersRef =
        _firestoreNewUserRepository.newUsernameCollection.doc(username);
    var result = await usersRef.get();
    if (result.exists) {
      return 'signup_this_user_taken'.tr;
    } else {
      return null;
    }
  }

  // static String

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'Must be equal to password';
    };
  }

  // ignore: close_sinks
  final showSuccessResponse = BooleanFieldBloc();

  @override
  void onSubmitting() async {
    if (showSuccessResponse.value) {
      emitSuccess();
    } else {
      emitFailure(failureResponse: 'This is an awesome error!');
    }
  }
}
