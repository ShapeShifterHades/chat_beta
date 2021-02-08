import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpFormBloc extends FormBloc<String, String> {
  SignUpFormBloc(this._authenticationRepository, this._firestoreNewUserRepository) {
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
    username
      ..addAsyncValidators([_checkUsername]);
  }


  final AuthenticationRepository _authenticationRepository;
  final FirestoreNewUserRepository _firestoreNewUserRepository;

  // ignore: close_sinks
  final username = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,      
    ],
    asyncValidatorDebounceTime: Duration(milliseconds: 500),
  );

  // ignore: close_sinks
  final showAgreementCheckbox = BooleanFieldBloc(validators: [
    FieldBlocValidators.required,]);
  // ignore: close_sinks
  final email = TextFieldBloc(
      name: 'Email field',
      initialValue: 'nigga@mm.ru',
      validators: [
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


  // ignore: unused_element
  // ignore: missing_return
  Future<String> _signUpFormSubmitted() async {
    UserCredential credential;
    emitLoading();
    try {
      credential = await _authenticationRepository.signUp(email: email.value, password: password.value,);
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
  Future<String> _checkUsername(String username) async {
      var usersRef = _firestoreNewUserRepository.newUsernameCollection.doc(username);
      usersRef.get()
        .then((docSnapshot){
          if (docSnapshot.exists) {
            print('It exists');
            return 'It exists';
          } else {
            print('Does not exist');
            return 'It not exists';
          }
      });
  }



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