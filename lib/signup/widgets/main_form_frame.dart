import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/login/widgets/main_frame/OrDivider.dart';
import 'package:void_chat_beta/login/widgets/main_frame/buttons_divider.dart';
import 'package:void_chat_beta/login/widgets/main_frame/settings_box.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/signup_with_google.dart';
import 'package:void_chat_beta/signup/widgets/submit_button.dart';
import 'package:void_chat_beta/signup/widgets/textfields_frame.dart';
import 'package:void_chat_beta/styles.dart';

import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';
import 'package:void_chat_beta/generated/l10n.dart';

/// Widget that represents main part of the Signup View
class SignupMainFormFrame extends StatefulWidget {
  SignupMainFormFrame({
    Key key,
  }) : super(key: key);

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

  // bool keyboardIsVisible = false;

  @override
  void initState() {
    formController = createController()
      ..play(duration: Times.fast)
      ..curve(Curves.easeInQuad);
    settingsController = createController();

    formFrameHeight = .0.tweenTo(310.0).animatedBy(formController);
    settingsFrameHeight = .0.tweenTo(160.0).animatedBy(settingsController);
    orLineHeight = .0.tweenTo(40.0).animatedBy(formController);
    orLineAlterHeight = .0.tweenTo(40.0).animatedBy(settingsController);

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
    return AnimatedAlign(
      duration: Times.fast,
      curve: Curves.easeIn,
      alignment: isKeyboardVisible ? Alignment.topCenter : Alignment.center,
      child: Container(
        margin: buildFormMargin(context),
        width: MediaQuery.of(context).size.width * .8,
        child: ClipPath(
          clipper: MainLoginFrameClipPath(),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isKeyboardVisible)
                  FormHeaderSignUp(
                    color: Theme.of(context).primaryColor,
                    title: S.of(context).signup_registration,
                    formController: formController,
                    settingsController: settingsController,
                  ),
                SettingsBox(settingsFrameHeight: settingsFrameHeight),
                TextfieldsFrame(formFrameHeight: formFrameHeight),
                SubmitButton(),
                ButtonsDivider(orLineAlterHeight: orLineAlterHeight),
                OrDivider(orLineHeight: orLineHeight),
                SignupWithGoogle(formController: formController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
