import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './view/new_signup_view.dart';

import 'bloc/sign_up_form_bloc.dart';

class NewSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SignUpFormBloc>(
            create: (context) => SignUpFormBloc(
              context.read<AuthenticationRepository>(),
              context.read<FirestoreNewUserRepository>(),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          // ignore: close_sinks
          final loginFormBloc = context.watch<SignUpFormBloc>();

          return SignUpView(loginFormBloc: loginFormBloc);
        }));
  }
}
