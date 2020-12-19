import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/provider/auth_ui_provider.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:void_chat_beta/ui/ui_base_elements/animated_frame/portrait/custom_full_frame_animated.dart';
import 'package:void_chat_beta/ui/ui_base_elements/auth_custom_frame/portrait/custom_clip_path.dart';
import 'package:void_chat_beta/ui/ui_base_elements/auth_custom_frame/portrait/custom_painter_for_clipper.dart';
import 'package:void_chat_beta/ui/widgets/auth/auth_form.dart';

import 'package:void_chat_beta/ui/widgets/auth/switch_auth_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  var visibleKbrd = false;
  AnimationController _slideInController;
  Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    _slideInController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideInController,
        curve: Curves.easeOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => _slideInController.forward().orCancel,
      );
    });

    // _slideInController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _slideInController.dispose();
  }

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
          AnimatedAlign(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
            alignment: visibleKbrd ? Alignment.topCenter : Alignment.center,
            child: SlideTransition(
              position: _slideInAnimation,
              child: AuthForm(
                slideInAnimation: _slideInAnimation,
                slideInController: _slideInController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
