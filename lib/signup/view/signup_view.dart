import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:void_chat_beta/signup/widgets/main_form_frame.dart';
import 'package:void_chat_beta/signup/widgets/switch_to_login.dart';

import 'package:simple_animations/simple_animations.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({
    Key key,
  }) : super(key: key);

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
      body: Stack(children: [
        SignupMainFormFrame(
          keyboardIsVisible: keyboardIsVisible,
        ),
        SwitchToLogin()
      ]),
    );
  }
}
