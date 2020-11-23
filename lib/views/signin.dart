import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/helper/helper_functions.dart';
import 'package:void_chat_beta/services/auth.dart';
import 'package:void_chat_beta/services/database.dart';
import 'package:void_chat_beta/views/chat_rooms_screen.dart';
import 'package:void_chat_beta/widgets/appbar.dart';
import 'package:void_chat_beta/widgets/decorated_textfield.dart';
import 'package:void_chat_beta/widgets/dont_have_account_yet.dart';
import 'package:void_chat_beta/widgets/signscreen_button.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot querySnapshotUserInfo;

  signInWithEmailAndPassword() async {
    if (formKey.currentState.validate()) {
      await HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        querySnapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            querySnapshotUserInfo.docs[0].get('name'));
      });

      await authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    DecoratedTextField(
                      hintText: 'email',
                      controller: emailTextEditingController,
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                .hasMatch(val)
                            ? null
                            : 'Invalid email';
                      },
                    ),
                    DecoratedTextField(
                      // TODO implement obscure text
                      validator: (val) {
                        return val.length > 6 ? null : 'Password is too short';
                      },
                      hintText: 'password',
                      controller: passwordTextEditingController,
                    )
                  ],
                ),
              ),
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
              GestureDetector(
                onTap: () {
                  signInWithEmailAndPassword();
                },
                child: SignScreenButton(
                  label: 'Sign In',
                  colors: kButtonMainGradientColor,
                  textColor: kMainTextColor,
                ),
              ),
              SizedBox(height: 16),
              SignScreenButton(
                label: 'Sign with Google',
                colors: kButtonSecondaryGradientColor,
                textColor: kSecondaryTextColor,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  widget.toggle();
                },
                child: DontHaveAccountYet(
                  text1: 'Don\'t have an account?',
                  text2: 'Register now',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
