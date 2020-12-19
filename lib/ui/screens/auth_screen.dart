import 'package:flutter/material.dart';

import 'package:void_chat_beta/ui/ui_base_elements/animated_frame/portrait/custom_full_frame_animated.dart';

import 'package:void_chat_beta/ui/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Positioned(
                  top: size.width * 0.05 + 30,
                  bottom: size.width * 0.05,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: CustomFullFrameAnimated(
                    size: size,
                  ),
                )
              : Container(),
          AuthForm(),
        ],
      ),
    );
  }
}
