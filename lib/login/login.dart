import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_form_bloc.dart';
import 'view/login_view.dart';

/// This page will be a replace for old Login page
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginFormBloc>(
            create: (context) => LoginFormBloc(AuthenticationRepository()),
          ),
        ],
        child: Builder(builder: (context) {
          // ignore: close_sinks
          final loginFormBloc = context.watch<LoginFormBloc>();

          return LoginView(loginFormBloc: loginFormBloc);
        }));
  }
}
