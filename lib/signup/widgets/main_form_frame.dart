import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/signup/widgets/switcher.dart';

import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:void_chat_beta/theme/locale_cubit.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';

/// Widget that represents main part of the Signup View
class SignupMainFormFrame extends StatefulWidget {
  final bool keyboardIsVisible;
  final SignUpFormBloc loginFormBloc;
  SignupMainFormFrame({this.keyboardIsVisible, this.loginFormBloc});

  @override
  _SignupMainFormFrameState createState() => _SignupMainFormFrameState();
}

class _SignupMainFormFrameState extends State<SignupMainFormFrame>
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
      ..play(duration: 700.milliseconds)
      ..curve(Curves.easeInQuad);
    settingsController = createController();

    formFrameHeight = 0.0.tweenTo(310.0).animatedBy(formController);
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
                            Color(0xffC7CCD1),
                            Color(0xffBCC2C8),
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
                            Color(0xffC7CCD1),
                            Color(0xffBCC2C8),
                          ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: ClipPath(
                            clipper: ScreenTagClipper(),
                            child: _buildEmailTextField(context)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: _buildPasswordTextField(context),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: _buildConfirmPasswordTextFied(context),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: _buildUsernameTextField(context),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: _buildLicenseAgreement(context),
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
                            Color(0xffC7CCD1),
                            Color(0xffBCC2C8),
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
                            Color(0xffC7CCD1),
                            Color(0xffBCC2C8),
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

  Padding _buildLicenseAgreement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: CheckboxFieldBlocBuilder(
        errorBuilder: (context, value) => 'signup_agree'.tr,
        checkColor: Theme.of(context).primaryColor,
        activeColor: Colors.transparent,
        padding: EdgeInsets.all(2),
        booleanFieldBloc: widget.loginFormBloc.showAgreementCheckbox,
        body: Container(
          clipBehavior: Clip.none,
          child: Row(
            children: [
              Text(
                'signup_i_agree'.tr,
                style: GoogleFonts.jura(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Theme.of(context).primaryTextTheme.bodyText1.color),
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
      textFieldBloc: widget.loginFormBloc.username,
      suffixButton: SuffixButton.asyncValidating,
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor,
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
      textFieldBloc: widget.loginFormBloc.confirmPassword,
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 0.5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor,
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
        fillColor: Theme.of(context).backgroundColor,
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
        fillColor: Theme.of(context).backgroundColor,
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
