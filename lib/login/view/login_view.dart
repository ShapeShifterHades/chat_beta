import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_main_form_frame.dart';
import 'package:void_chat_beta/login/widgets/switch_to_signup_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key key,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with AnimationMixin {
  bool keyboardIsVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboardIsVisible = visible;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BlocProvider(
            create: (context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: LoginMainFormFrame(
              keyboardIsVisible: keyboardIsVisible,
            ),
          ),
          SwitchToSignUpButton()
        ],
      ),
    );
  }
}
