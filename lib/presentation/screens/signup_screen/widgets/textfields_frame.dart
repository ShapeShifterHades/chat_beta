import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/confirm_password_input.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/email_input.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/licence_agreement_tile.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/password_input.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/username_input.dart';

class TextfieldsFrame extends StatelessWidget {
  const TextfieldsFrame({
    Key? key,
    required this.formFrameHeight,
  }) : super(key: key);

  final Animation<double>? formFrameHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: formFrameHeight!.value,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.4),
            border: Border.symmetric(
              vertical:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.2),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                EmailInput(),
                PasswordInput(),
                ConfirmPasswordInput(),
                UsernameInput(),
                LicenceAgreementTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
