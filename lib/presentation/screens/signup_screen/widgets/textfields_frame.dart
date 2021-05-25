import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/confirm_password_input.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/email_input.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/licence_agreement_tile.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/password_input.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields/username_input.dart';

class TextfieldsFrame extends StatefulWidget {
  const TextfieldsFrame({
    Key? key,
    required this.formFrameHeight,
  }) : super(key: key);

  final Animation<double>? formFrameHeight;

  @override
  _TextfieldsFrameState createState() => _TextfieldsFrameState();
}

class _TextfieldsFrameState extends State<TextfieldsFrame> {
  late FocusNode emailNode;
  late FocusNode passwordNode;
  late FocusNode confirmPasswordNode;
  late FocusNode usernameNode;

  @override
  void initState() {
    super.initState();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    usernameNode = FocusNode();
  }

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    usernameNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: widget.formFrameHeight!.value,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.4),
            border: Border.symmetric(
              vertical:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.2),
            ),
          ),
          child: Scrollbar(
            radius: const Radius.circular(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmailInput(node: emailNode, nextNode: passwordNode),
                    PasswordInput(
                        node: passwordNode, nextNode: confirmPasswordNode),
                    ConfirmPasswordInput(
                        node: confirmPasswordNode, nextNode: usernameNode),
                    UsernameInput(node: usernameNode),
                    LicenceAgreementTile(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
