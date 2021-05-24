import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/main_frame/login_main_form_frame.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/svg_background.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/switch_to_signup_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: KeyboardVisibilityProvider(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: const [
              SvgBackground(),
              LoginMainFormFrame(
                key: ValueKey('login_main_form_frame'),
              ),
              SwitchToSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
