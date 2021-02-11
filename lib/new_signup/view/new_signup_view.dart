import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:void_chat_beta/new_signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/new_signup/widgets/main_form_frame.dart';

import 'package:void_chat_beta/theme/brightness_cubit.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum FormfieldProps {
  width,
  emailFormHeight,
  passwordFormHeight,
  confirmPasswordFormHeight,
  usernameFormHeight,
  termsFormHeight,
  orLineHeight,
}

class SignUpView extends StatefulWidget {
  const SignUpView({
    Key key,
    @required this.loginFormBloc,
  }) : super(key: key);

  final SignUpFormBloc loginFormBloc;

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with AnimationMixin {
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
      body: FormBlocListener<SignUpFormBloc, String, String>(
        onSubmitting: (context, state) {},
        onSuccess: (context, state) {},
        onFailure: (context, state) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(state.failureResponse)));
        },
        // Stack is not really nessesary here so it should be deleted soon
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            Color(0xFF2D2E2E),
                            Color(0xFF141515),
                          ]
                        : [
                            Color(0xffFFF9FB),
                            Color(0xffFBFBFB),
                          ],
                  ),
                ),
                child: AnimatedAlign(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  alignment: keyboardIsVisible
                      ? Alignment.topCenter
                      : Alignment.center,
                  child: SignupMainFormFrame(
                    loginFormBloc: widget.loginFormBloc,
                    keyboardIsVisible: keyboardIsVisible,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
