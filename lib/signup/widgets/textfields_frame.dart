import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/textfields/confirm_password_input.dart';
import 'package:void_chat_beta/signup/widgets/textfields/email_input.dart';
import 'package:void_chat_beta/signup/widgets/textfields/password_input.dart';
import 'package:void_chat_beta/signup/widgets/textfields/username_input.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';

class TextfieldsFrame extends StatelessWidget {
  const TextfieldsFrame({
    Key key,
    @required this.formFrameHeight,
  }) : super(key: key);

  final Animation<double> formFrameHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: formFrameHeight.value,
      width: Get.size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: buildFormBackground3(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: ClipPath(clipper: ScreenTagClipper(), child: EmailInput()),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: PasswordInput(),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: ConfirmPasswordInput(),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: UsernameInput(),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                  child: Text('License here', style: TextStyles.body1)),
            ),
          ],
        ),
      ),
    );
  }
}
