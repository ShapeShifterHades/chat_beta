import 'package:flutter/material.dart';
import 'package:void_chat_beta/helper/helper_functions.dart';
import 'package:void_chat_beta/services/auth.dart';
import 'package:void_chat_beta/views/chat_rooms_screen.dart';
import 'package:void_chat_beta/widgets/appbar.dart';
import 'package:void_chat_beta/widgets/decorated_textfield.dart';
import 'package:void_chat_beta/widgets/dont_have_account_yet.dart';
import 'package:void_chat_beta/widgets/signscreen_button.dart';

import '../constants.dart';
import '../services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  HelperFunctions helperFunctions = HelperFunctions();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await authMethods.signUpWithEmailAndPassword(
            emailTextEditingController.text,
            passwordTextEditingController.text);

        Map<String, String> userInfoMap = {
          'name': usernameTextEditingController.text,
          'email': emailTextEditingController.text,
        };
        await helperFunctions.saveUserLoggedInSharedPreference(true);
        await helperFunctions
            .saveUserNameSharedPreference(usernameTextEditingController.text);
        await helperFunctions
            .saveUserEmailSharedPreference(emailTextEditingController.text);

        await databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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
                              validator: (val) {
                                return val.length < 4 ? 'Invalid name' : null;
                              },
                              hintText: 'username',
                              controller: usernameTextEditingController),
                          DecoratedTextField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)
                                    ? null
                                    : 'Invalid email';
                              },
                              hintText: 'email',
                              controller: emailTextEditingController),
                          DecoratedTextField(
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : 'Password is too short';
                              },
                              // obsure: true,
                              hintText: 'password',
                              controller: passwordTextEditingController),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      func: signMeUp,
                      label: 'Sign Up',
                      colors: kButtonMainGradientColor,
                      textColor: kMainTextColor,
                    ),
                    SizedBox(height: 16),
                    SignScreenButton(
                      label: 'Sign up with Google',
                      colors: kButtonSecondaryGradientColor,
                      textColor: kSecondaryTextColor,
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: DontHaveAccountYet(
                        text1: 'Already have an account?',
                        text2: 'Sign In',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
