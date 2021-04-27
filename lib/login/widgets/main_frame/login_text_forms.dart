import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:void_chat_beta/login/widgets/main_frame/formfields/password_input.dart';

import 'formfields/email_input.dart';

class LoginTextForms extends StatelessWidget {
  const LoginTextForms({
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
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.4),
            border: Border.symmetric(
              vertical:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.2),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: EmailInput(),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: PasswordInput(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
