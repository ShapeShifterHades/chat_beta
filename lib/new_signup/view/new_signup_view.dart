import 'dart:ui';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/new_signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/signup/widgets/form_header_signup.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_painter_for_clipper.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { width, height, color }

class SignUpView extends StatelessWidget {
  const SignUpView({
    Key key,
    @required this.loginFormBloc,
  }) : super(key: key);

  final SignUpFormBloc loginFormBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: FormBlocListener<SignUpFormBloc, String, String>(
        onSubmitting: (context, state) {},
        onSuccess: (context, state) {},
        onFailure: (context, state) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(state.failureResponse)));
        },
        child: Column(
          children: [
            _buildMainForm(context),
          ],
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////
  Container _buildMainForm(BuildContext context) {
    final _tween = TimelineTween<AniProps>()
      // ..addScene(begin: 0.milliseconds, end: 1000.milliseconds)
      //     .animate(AniProps.width, tween: 0.0.tweenTo(100.0))
      // ..addScene(begin: 1000.milliseconds, end: 1500.milliseconds)
      //     .animate(AniProps.width, tween: 100.0.tweenTo(200.0))
      ..addScene(begin: 0.milliseconds, duration: 1500.milliseconds)
          .animate(AniProps.height, tween: 0.0.tweenTo(300.0));
    // ..addScene(begin: 0.milliseconds, duration: 3.seconds)
    //     .animate(AniProps.color, tween: Colors.red.tweenTo(Colors.blue));

    return Container(
      margin: EdgeInsets.only(
        top: 40,
        left: Get.size.width * 0.03,
        right: Get.size.width * 0.03,
      ),
      width: Get.size.width * 0.95,
      alignment: Alignment.center,
      child: CustomPaint(
        painter: CustomPainterForClipper(
          color: Theme.of(context).primaryColor,
        ),
        child: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            color: Theme.of(context).accentColor, // EXPERIMENTAL COLOR FOR UI
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormHeaderSignUp(
                  color: Theme.of(context).backgroundColor,
                  title: 'signup_registration'.tr,
                ),
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,

                  builder: (context, child, value) {
                    return Container(
                      height: value.get(AniProps.height),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          value.get(AniProps.height) > 80
                              ? _buildEmailTextField(context)
                              : Container(),
                          value.get(AniProps.height) > 130
                              ? _buildPasswordTextField(context)
                              : Container(),
                          value.get(AniProps.height) > 190
                              ? _buildConfirmPasswordTextFied(context)
                              : Container(),
                          value.get(AniProps.height) > 250
                              ? _buildUsernameTextField(context)
                              : Container(),
                          value.get(AniProps.height) > 295
                              ? _buildLicenseAgreement(context)
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleButtonOne(
                        text: 'signup_submit'.tr,
                        onPressed: loginFormBloc.submit,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 0.4,
                          indent: 12,
                          endIndent: 12,
                        ),
                      ),
                      Text(
                        'signup_or'.tr,
                        style: GoogleFonts.jura(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Expanded(
                          child: Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 0.4,
                        indent: 12,
                        endIndent: 12,
                      )),
                    ],
                  ),
                ),
                Container(
                  width: 500,
                  clipBehavior: Clip.none,
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleButtonOne(
                        text: 'signup_with_google'.tr,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildLicenseAgreement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CheckboxFieldBlocBuilder(
        checkColor: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).accentColor,
        padding: EdgeInsets.all(2),
        booleanFieldBloc: loginFormBloc.showAgreementCheckbox,
        body: Container(
          child: Row(
            children: [
              Text(
                'signup_i_agree'.tr,
                style: GoogleFonts.jura(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .color
                        .withOpacity(0.7)),
              ),
              FlatButton(
                padding: EdgeInsets.all(5),
                onPressed: () {},
                child: Text(
                  'signup_with_terms'.tr,
                  style: GoogleFonts.jura(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildUsernameTextField(BuildContext context) {
    return TextFieldBlocBuilder(
      padding: EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 2),
      isEnabled: true,
      textFieldBloc: loginFormBloc.username,
      suffixButton: SuffixButton.asyncValidating,
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        labelStyle: GoogleFonts.jura(
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'signup_username'.tr,
        prefixIcon: Icon(
          Icons.person_add,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildConfirmPasswordTextFied(BuildContext context) {
    return TextFieldBlocBuilder(
      padding: EdgeInsets.all(2),
      isEnabled: true,
      textFieldBloc: loginFormBloc.confirmPassword,
      suffixButton: SuffixButton.obscureText,
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        labelStyle: GoogleFonts.jura(
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'signup_confirm_password'.tr,
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildPasswordTextField(BuildContext context) {
    return TextFieldBlocBuilder(
      padding: EdgeInsets.all(2),
      textFieldBloc: loginFormBloc.password,
      suffixButton: SuffixButton.obscureText,
      style: GoogleFonts.jura(
          color: Theme.of(context).primaryTextTheme.bodyText1.color),
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
        labelText: 'signup_password'.tr,
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildEmailTextField(BuildContext context) {
    return TextFieldBlocBuilder(
      padding: EdgeInsets.all(2),
      textFieldBloc: loginFormBloc.email,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.jura(
          color: Theme.of(context).primaryTextTheme.bodyText1.color),
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
        labelText: 'signup_email'.tr,
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

class SimpleButtonOne extends StatelessWidget {
  final String text;
  final Function onPressed;
  const SimpleButtonOne({
    Key key,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ScreenTagClipper(),
      child: MaterialButton(
        onPressed: onPressed ?? () {},
        highlightColor: Theme.of(context).backgroundColor.withOpacity(0.14),
        child: Text(
          text,
          style: GoogleFonts.jura(
              fontWeight: FontWeight.w300,
              color: Theme.of(context).backgroundColor),
        ),
      ),
    );
  }
}

class ShimmerTextSwitch extends StatelessWidget {
  const ShimmerTextSwitch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context)
          .inputDecorationTheme
          .enabledBorder
          .borderSide
          .color
          .withOpacity(0.35),
      highlightColor: Theme.of(context)
          .inputDecorationTheme
          .enabledBorder
          .borderSide
          .color
          .withOpacity(1),
      loop: 0,
      period: Duration(milliseconds: 2500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Switch to Login',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 10),
          Transform.translate(
            offset: Offset(0.0, 1.5),
            child: Transform(
              transform: Matrix4.diagonal3Values(1, 0.85, 1.2),
              child: Icon(
                Icons.double_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
