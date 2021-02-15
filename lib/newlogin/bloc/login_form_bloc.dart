import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class LoginFormBloc extends FormBloc<String, String> {
  final AuthenticationRepository _authenticationRepository;

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

  LoginFormBloc(this._authenticationRepository)
      : assert(_authenticationRepository != null) {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }
  // ignore: unused_element
  // ignore: missing_return
  Future<String> _loginFormSubmitted() async {
    emitLoading();
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      try {
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

  // ignore: close_sinks
  final showSuccessResponse = BooleanFieldBloc();

  @override
  void onSubmitting() async {
    try {
      _loginFormSubmitted();
    } catch (e) {
      print(e);
      emitFailure(failureResponse: e.toString());
    }
    // if (showSuccessResponse.value) {
    //   _signUpFormSubmitted();
    //   emitSuccess();
    // } else {
    //   emitFailure(failureResponse: 'This is an awesome error!');
    // }
  }
}
