import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/new_signup/widgets/switcher.dart';
import 'package:void_chat_beta/newlogin/bloc/login_form_bloc.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:void_chat_beta/theme/locale_cubit.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';

/// Widget that represents main part of the Signup View
class LoginMainFormFrame extends StatefulWidget {
  final bool keyboardIsVisible;
  final LoginFormBloc loginFormBloc;
  LoginMainFormFrame({this.keyboardIsVisible, this.loginFormBloc});

  @override
  _LoginMainFormFrameState createState() => _LoginMainFormFrameState();
}

class _LoginMainFormFrameState extends State<LoginMainFormFrame>
    with AnimationMixin {
  /// Controller that is taking care of animation, is set to be played after widget first build
  AnimationController formController;
  AnimationController settingsController;

  Animation<double> formFrameHeight;
  Animation<double> settingsFrameHeight;
  Animation<double> orLineHeight;
  Animation<double> orLineAlterHeight;

  @override
  void initState() {
    formController = createController()
      ..play(duration: 400.milliseconds)
      ..curve(Curves.easeInQuad);
    settingsController = createController();

    formFrameHeight = 0.0.tweenTo(180.0).animatedBy(formController);
    settingsFrameHeight = 0.0.tweenTo(160.0).animatedBy(settingsController);
    orLineHeight = 0.0.tweenTo(40.0).animatedBy(formController);
    orLineAlterHeight = 0.0.tweenTo(40.0).animatedBy(settingsController);
    super.initState();
  }

  _toggleLocale() {
    context.read<LocaleCubit>().toggleLocale();
    Get.updateLocale(Locale(context.read<LocaleCubit>().state));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
        left: Get.size.width * 0.03,
        right: Get.size.width * 0.03,
      ),
      width: Get.size.width * 0.95,
      child: ClipPath(
        clipper: CustomClipPath(),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.keyboardIsVisible
                  ? Container()
                  : FormHeaderSignUp(
                      color: Theme.of(context).primaryColor,
                      title: 'signup_registration'.tr,
                      formController: formController,
                      settingsController: settingsController,
                    ),

              /// Form part, that is controlled by [settingsController] and its size is defined by [settingsFrameHeight] tween value.
              ///
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            Color(0xff2f353c),
                            Color(0xff181f27),
                          ]
                        : [
                            Color(0xffE0E0E0),
                            Color(0xffEBEBEB),
                          ],
                  ),
                ),
                width: Get.size.width * 0.9,
                height: settingsFrameHeight.value,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Brightness'),
                          Switcher(
                            onChange: context
                                .watch<BrightnessCubit>()
                                .toggleBrightness,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Locale'),
                          Switcher(
                            onChange: _toggleLocale,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Form part, that is controlled by [formController] and its size is defined by [formFrameHeight] tween value.
              ///
              Container(
                height: formFrameHeight.value,
                width: Get.size.width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            Color(0xff2f353c),
                            Color(0xff181f27),
                          ]
                        : [
                            Color(0xffE0E0E0),
                            Color(0xffEBEBEB),
                          ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: _buildEmailTextField(context),
                      ),
                      Container(
                        height: 80,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: _buildPasswordTextField(context),
                      ),
                    ],
                  ),
                ),
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
                      onPressed: widget.loginFormBloc.submit,
                    ),
                  ],
                ),
              ),

              /// orAlterLine part, that is built to replace [_buildOrLine], controlled by [settingsController] and its size is defined by [orLineAlterHeight] tween value.
              ///
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            Color(0xff2f353c),
                            Color(0xff181f27),
                          ]
                        : [
                            Color(0xffE0E0E0),
                            Color(0xffEBEBEB),
                          ],
                  ),
                ),
                width: Get.size.width * 0.9,
                height: orLineAlterHeight.value,
              ),

              /// orLine part, that is built by [_buildOrLine], controlled by [formController] and its size is defined by [orLineHeight] tween value.
              ///
              Container(
                width: Get.size.width * 0.9,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: context.watch<BrightnessCubit>().state ==
                            Brightness.dark
                        ? [
                            Color(0xff2f353c),
                            Color(0xff181f27),
                          ]
                        : [
                            Color(0xffE0E0E0),
                            Color(0xffEBEBEB),
                          ],
                  ),
                ),
                height: orLineHeight.value,
                child: SingleChildScrollView(child: _buildOrLine(context)),
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
                      onPressed: formController.value == 0.0 ? null : () {},
                    ),
                  ],
                ),
              ),
            ],
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

  TextFieldBlocBuilder _buildPasswordTextField(BuildContext context) {
    return TextFieldBlocBuilder(
      padding: EdgeInsets.all(2),
      textFieldBloc: widget.loginFormBloc.password,
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
      textFieldBloc: widget.loginFormBloc.email,
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
  final bool enabled;
  final String text;
  final Function onPressed;
  const SimpleButtonOne({
    Key key,
    @required this.text,
    this.onPressed,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ScreenTagClipper(),
      child: MaterialButton(
        disabledColor: Theme.of(context).backgroundColor,
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
