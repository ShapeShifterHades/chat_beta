import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/widgets/appbar.dart';
import 'package:void_chat_beta/widgets/decorated_textfield.dart';
import 'package:void_chat_beta/widgets/dont_have_account_yet.dart';
import 'package:void_chat_beta/widgets/signscreen_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedTextField(hintText: 'email'),
              DecoratedTextField(hintText: 'password'),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: kMainTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SignScreenButton(
                label: 'Sign In',
                colors: kButtonMainGradientColor,
                textColor: kMainTextColor,
              ),
              SizedBox(height: 16),
              SignScreenButton(
                label: 'Sign with Google',
                colors: kButtonSecondaryGradientColor,
                textColor: kSecondaryTextColor,
              ),
              SizedBox(height: 16),
              DontHaveAccountYet(
                text1: 'Don\'t have an account?',
                text2: 'Register now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
