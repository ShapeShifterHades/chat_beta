import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_main_form_frame.dart';
import 'package:void_chat_beta/login/widgets/switch_to_signup_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            LoginMainFormFrame(),
            SwitchToSignUpButton(),
          ],
        ),
      ),
    );
  }
}
