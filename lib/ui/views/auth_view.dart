import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/main_side/frame/animated_frame/portrait/custom_full_frame_animated.dart';

import 'package:void_chat_beta/ui/widgets/auth/auth_form.dart';

class AuthView extends StatelessWidget {
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
                  ))
              : Container(),
          AuthForm(),
        ],
      ),
    );
  }
}
