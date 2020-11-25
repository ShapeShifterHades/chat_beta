import 'package:flutter/material.dart';
import 'package:void_chat_beta/views/signin.dart';
import 'package:void_chat_beta/views/signup.dart';

class AuthenticationHelper extends StatefulWidget {
  @override
  _AuthenticationHelperState createState() => _AuthenticationHelperState();
}

class _AuthenticationHelperState extends State<AuthenticationHelper> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
        toggle: toggleView,
      );
    } else {
      return SignUp(
        toggle: toggleView,
      );
    }
  }
}
