import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_main_form_frame.dart';
import 'package:void_chat_beta/login/widgets/switch_to_signup_button.dart';
import 'package:void_chat_beta/widgets/svg_background.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: KeyboardVisibilityProvider(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SvgBackground(),
              LoginMainFormFrame(),
              SwitchToSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
