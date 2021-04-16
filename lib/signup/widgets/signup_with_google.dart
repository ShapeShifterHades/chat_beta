import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/signup/widgets/simple_button_one.dart';

class SignupWithGoogle extends StatelessWidget {
  const SignupWithGoogle({
    Key key,
    @required this.formController,
  }) : super(key: key);

  final AnimationController formController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 30,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleButtonOne(
            text: 'signup_with_google'.tr,
            onPressed: formController.value == 0.0 ? null : () {},
          ),
        ],
      ),
    );
  }
}
