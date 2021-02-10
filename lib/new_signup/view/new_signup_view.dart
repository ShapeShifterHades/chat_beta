import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/new_signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/signup/widgets/form_header_signup.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_painter_for_clipper.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps {
  width,
  form1Height,
  form2Height,
  form3Height,
  form4Height,
  form5Height,
  orHeight,
  color,
}

enum BgcolorProps { color1, color2, color3 }

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
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            // Color(0xff2f353c),
                            // Color(0xff181f27),
                            Color(0xFF2D2E2E),
                            Color(0xFF141515),
                          ]
                        : [
                            Color(0xffFFF9FB),
                            Color(0xffFBFBFB),
                          ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMainForm(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds main frame of the screen with forms and buttons
  Container _buildMainForm(BuildContext context) {
    final _tween = TimelineTween<AniProps>()

      /// Adds initial animation for [_buildEmailTextField] that has duration of [duration] and starts at [begin]
      ///
      ..addScene(begin: 350.milliseconds, duration: 700.milliseconds)
          .animate(AniProps.form1Height, tween: 0.0.tweenTo(60.0))

      /// Adds initial animation for [_buildPasswordTextField] that has duration of [duration] and starts at [begin]
      ///
      ..addScene(begin: 400.milliseconds, duration: 700.milliseconds)
          .animate(AniProps.form2Height, tween: 0.0.tweenTo(60.0))

      /// Adds initial animation for [_buildConfirmPasswordTextFied] that has duration of [duration] and starts at [begin]
      ///
      ..addScene(begin: 450.milliseconds, duration: 700.milliseconds)
          .animate(AniProps.form3Height, tween: 0.0.tweenTo(60.0))

      /// Adds initial animation for [_buildUsernameTextField] that has duration of [duration] and starts at [begin]
      ///
      ..addScene(begin: 550.milliseconds, duration: 700.milliseconds)
          .animate(AniProps.form4Height, tween: 0.0.tweenTo(60.0))

      /// Adds initial animation for [_buildLicenseAgreement] that has duration of [duration] and starts at [begin]
      ///
      ..addScene(begin: 600.milliseconds, duration: 700.milliseconds)
          .animate(AniProps.form5Height, tween: 0.0.tweenTo(90.0))

      /// Adds initial animation for [_buildOrLine] that has duration of [duration] and starts at [begin]
      ///
      ..addScene(begin: 350.milliseconds, duration: 700.milliseconds)
          .animate(AniProps.orHeight, tween: 0.0.tweenTo(40.0));

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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors:
                    context.watch<BrightnessCubit>().state == Brightness.dark
                        ? [
                            Color(0xff2f353c),
                            Color(0xff181f27),
                          ]
                        : [
                            Color(0xffFFF9FB),
                            Color(0xffFBFBFB),
                          ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormHeaderSignUp(
                  color: Theme.of(context).primaryColor,
                  title: 'signup_registration'.tr,
                ),
                SizedBox(
                  height: 10,
                ),
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,
                  builder: (context, child, value) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: value.get(AniProps.form1Height),
                      child: value.get(AniProps.form1Height) > 52
                          ? _buildEmailTextField(context)
                          : Container(),
                    );
                  },
                ),
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,
                  builder: (context, child, value) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: value.get(AniProps.form2Height),
                      child: value.get(AniProps.form2Height) > 52
                          ? _buildPasswordTextField(context)
                          : Container(),
                    );
                  },
                ),
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,
                  builder: (context, child, value) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: value.get(AniProps.form3Height),
                      child: value.get(AniProps.form3Height) > 52
                          ? _buildConfirmPasswordTextFied(context)
                          : Container(),
                    );
                  },
                ),
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,
                  builder: (context, child, value) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: value.get(AniProps.form4Height),
                      child: value.get(AniProps.form4Height) > 52
                          ? _buildUsernameTextField(context)
                          : Container(),
                    );
                  },
                ),
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,

                  builder: (context, child, value) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: value.get(AniProps.form5Height),
                      child: value.get(AniProps.form5Height) > 52
                          ? _buildLicenseAgreement(context)
                          : Container(),
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
                PlayAnimation<TimelineValue<AniProps>>(
                  tween: _tween, // Pass in tween
                  duration: _tween.duration,

                  builder: (context, child, value) {
                    return Container(
                      height: value.get(AniProps.orHeight),
                      child: value.get(AniProps.orHeight) > 39
                          ? _buildOrLine(context)
                          : Container(),
                    );
                  },
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

  Container _buildOrLine(BuildContext context) {
    return Container(
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
    );
  }

  Padding _buildLicenseAgreement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CheckboxFieldBlocBuilder(
        checkColor: Theme.of(context).primaryColor,
        activeColor: Colors.transparent,
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
          Icons.person_add_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildConfirmPasswordTextFied(BuildContext context) {
    return TextFieldBlocBuilder(
      suffixButton: SuffixButton.obscureText,
      obscureTextFalseIcon: Icon(
        Icons.visibility_off_outlined,
        color: Theme.of(context).primaryColor,
      ),
      obscureTextTrueIcon: Icon(
        Icons.visibility_outlined,
        color: Theme.of(context).primaryColor,
      ),
      padding: EdgeInsets.all(2),
      isEnabled: true,
      textFieldBloc: loginFormBloc.confirmPassword,
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        labelStyle: GoogleFonts.jura(
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'signup_confirm_password'.tr,
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildPasswordTextField(BuildContext context) {
    return TextFieldBlocBuilder(
      padding: EdgeInsets.all(2),
      textFieldBloc: loginFormBloc.password,
      suffixButton: SuffixButton.obscureText,
      obscureTextFalseIcon: Icon(
        Icons.visibility_off_outlined,
        color: Theme.of(context).primaryColor,
      ),
      obscureTextTrueIcon: Icon(
        Icons.visibility_outlined,
        color: Theme.of(context).primaryColor,
      ),
      style: GoogleFonts.jura(
          color: Theme.of(context).primaryTextTheme.bodyText1.color),
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
        labelText: 'signup_password'.tr,
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  TextFieldBlocBuilder _buildEmailTextField(BuildContext context) {
    return TextFieldBlocBuilder(
      key: Key('signup_email_form_key'),
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
          Icons.mail_outline,
          color: Theme.of(context).primaryColor,
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
