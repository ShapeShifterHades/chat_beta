import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

import 'package:void_chat_beta/newlogin/bloc/login_form_bloc.dart';
import 'package:void_chat_beta/newlogin/widgets/login_main_form_frame.dart';

import 'package:void_chat_beta/theme/brightness_cubit.dart';

import 'package:simple_animations/simple_animations.dart';

class NewLoginView extends StatefulWidget {
  const NewLoginView({
    Key key,
    @required this.loginFormBloc,
  }) : super(key: key);

  final LoginFormBloc loginFormBloc;

  @override
  _NewLoginViewState createState() => _NewLoginViewState();
}

class _NewLoginViewState extends State<NewLoginView> with AnimationMixin {
  bool keyboardIsVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboardIsVisible = visible;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: FormBlocListener<LoginFormBloc, String, String>(
        onSubmitting: (context, state) {
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Submitting'),
          //   ),
          // );
        },
        onSuccess: (context, state) {
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.successResponse),
          //   ),
          // );
        },
        onFailure: (context, state) {
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.failureResponse),
          //   ),
          // );
        },
        child: Stack(
          children: [
            /// [LoginMainFormFrame] with its background and positioning.
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            Color(0xFF2D2E2E),
                            Color(0xFF141515),
                          ]
                        : [
                            Color(0xffF4F5F6),
                            Color(0xffFFFFFF),
                          ],
                  ),
                ),
                child: AnimatedAlign(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  alignment: keyboardIsVisible
                      ? Alignment.topCenter
                      : Alignment.center,
                  child: LoginMainFormFrame(
                    loginFormBloc: widget.loginFormBloc,
                    keyboardIsVisible: keyboardIsVisible,
                  ),
                ),
              ),
            ),

            /// Button for switchichg between [SignUp] and [Login] forms.
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/newSignUp');
                  },
                  child: Container(
                    child: Shimmer.fromColors(
                      baseColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      highlightColor: Theme.of(context).primaryColor,
                      loop: 0,
                      period: Duration(milliseconds: 2500),
                      child: Text(
                        'loginpage_switch_to_registration'.tr,
                        style: GoogleFonts.jura(
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
