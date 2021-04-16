import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/settings_frame.dart';
import 'package:void_chat_beta/signup/widgets/signup_with_google.dart';
import 'package:void_chat_beta/signup/widgets/submit_button.dart';
import 'package:void_chat_beta/signup/widgets/textfields_frame.dart';
import 'package:void_chat_beta/styles.dart';

import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';

import 'or_line.dart';

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

  bool keyboardIsVisible = false;
  KeyboardVisibilityNotification _keyboardVisibilityNotification =
      KeyboardVisibilityNotification();

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

    _keyboardVisibilityNotification.addNewListener(
      onChange: (bool visible) {
        keyboardIsVisible = visible;
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // formController.dispose();
    // settingsController.dispose();
    _keyboardVisibilityNotification.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: buildFormBackground1(context),
        child: AnimatedAlign(
          duration: Times.fast,
          curve: Curves.easeIn,
          alignment: keyboardIsVisible ? Alignment.topCenter : Alignment.center,
          child: Container(
            margin: buildFormMargin(),
            width: Get.size.width * 0.95,
            child: ClipPath(
              clipper: MainLoginFrameClipPath(),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!keyboardIsVisible)
                      FormHeaderSignUp(
                        color: Theme.of(context).primaryColor,
                        title: 'signup_registration'.tr,
                        formController: formController,
                        settingsController: settingsController,
                      ),
                    SettingsFrame(settingsFrameHeight: settingsFrameHeight),
                    TextfieldsFrame(formFrameHeight: formFrameHeight),
                    SubmitButton(),
                    _OrLineReplacement(orLineAlterHeight: orLineAlterHeight),
                    OrLine(orLineHeight: orLineHeight),
                    SignupWithGoogle(formController: formController),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrLineReplacement extends StatelessWidget {
  const _OrLineReplacement({
    Key key,
    @required this.orLineAlterHeight,
  }) : super(key: key);

  final Animation<double> orLineAlterHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildFormBackground4(context),
      width: Get.size.width * 0.9,
      height: orLineAlterHeight.value,
    );
  }
}
