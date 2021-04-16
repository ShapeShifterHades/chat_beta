import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/login/widgets/main_frame/formfields/password_input.dart';

import 'formfields/email_input.dart';
import 'constants.dart';

class LoginTextForms extends StatelessWidget {
  const LoginTextForms({
    Key key,
    @required this.formFrameHeight,
  }) : super(key: key);

  final Animation<double> formFrameHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: formFrameHeight.value,
      width: Get.size.width * 0.9,
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: buildFormFieldBackground(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 5, right: 5, top: 20),
              child: EmailInput(),
            ),
            Container(
              height: 80,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: PasswordInput(),
            ),
          ],
        ),
      ),
    );
  }
}
