import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/login/widgets/main_frame/OrDivider.dart';
import 'package:void_chat_beta/login/widgets/main_frame/buttons_divider.dart';
import 'package:void_chat_beta/login/widgets/main_frame/constants.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_submit_button.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_text_forms.dart';
import 'package:void_chat_beta/login/widgets/main_frame/settings_box.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';
import 'package:void_chat_beta/generated/l10n.dart';

import 'button_model.dart';

/// Widget that represents main part of the Signup View
class LoginMainFormFrame extends StatefulWidget {
  LoginMainFormFrame({
    Key? key,
  }) : super(key: key);

  @override
  _LoginMainFormFrameState createState() => _LoginMainFormFrameState();
}

class _LoginMainFormFrameState extends State<LoginMainFormFrame>
    with AnimationMixin {
  /// Controller that is taking care of animation, is set to be played after widget first build
  AnimationController? _formController;
  AnimationController? _settingsController;
  // Whether keyboard is opened or not.
  // bool keyboardIsVisible = false;
  // Notification provider for keyboard opening.

  Animation<double>? formFrameHeight;
  Animation<double>? settingsFrameHeight;
  Animation<double>? orLineHeight;
  Animation<double>? orLineAlterHeight;

  @override
  void initState() {
    _formController = createController()
      ..play(duration: Times.fast)
      ..curve(Curves.easeInQuad);
    _settingsController = createController();

    formFrameHeight = 0.0.tweenTo(168.0).animatedBy(_formController!);
    settingsFrameHeight = 0.0.tweenTo(160.0).animatedBy(_settingsController!);
    orLineHeight = 0.0.tweenTo(40.0).animatedBy(_formController!);
    orLineAlterHeight = 0.0.tweenTo(40.0).animatedBy(_settingsController!);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Positioned.fill(
      child: Container(
        child: AnimatedAlign(
          duration: Times.medium,
          curve: Curves.easeIn,
          alignment: isKeyboardVisible ? Alignment.topCenter : Alignment.center,
          child: Container(
            margin: buildMainFrameMargin(context),
            width: MediaQuery.of(context).size.width * .8,
            child: ClipPath(
              clipper: MainLoginFrameClipPath(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isKeyboardVisible)
                    FormHeaderSignUp(
                      color: Theme.of(context).primaryColor,
                      title: S.of(context)!.loginpage_login_form,
                      formController: _formController,
                      settingsController: _settingsController,
                    ),
                  SettingsBox(settingsFrameHeight: settingsFrameHeight),
                  LoginTextForms(formFrameHeight: formFrameHeight),
                  LoginSubmitButton(),
                  ButtonsDivider(orLineAlterHeight: orLineAlterHeight),
                  OrDivider(orLineHeight: orLineHeight),
                  ButtonModel(
                    text: S.of(context)!.loginpage_login_with_google,
                    onPressed: _formController!.value == 0.0 ? null : () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
