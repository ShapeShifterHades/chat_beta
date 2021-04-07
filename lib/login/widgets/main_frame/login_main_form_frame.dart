import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/main_frame/OrDivider.dart';
import 'package:void_chat_beta/login/widgets/main_frame/buttons_divider.dart';
import 'package:void_chat_beta/login/widgets/main_frame/constants.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_submit_button.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_text_forms.dart';
import 'package:void_chat_beta/login/widgets/main_frame/settings_box.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';

import 'button_model.dart';

/// Widget that represents main part of the Signup View
class LoginMainFormFrame extends StatefulWidget {
  final bool keyboardIsVisible;
  LoginMainFormFrame({this.keyboardIsVisible});

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {},
      child: Positioned.fill(
        child: Container(
          decoration: buildBgBoxDecoration(context),
          child: AnimatedAlign(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            alignment: widget.keyboardIsVisible
                ? Alignment.topCenter
                : Alignment.center,
            child: Container(
              margin: buildMainFrameMargin(),
              width: Get.size.width * 0.95,
              child: ClipPath(
                clipper: MainLoginFrameClipPath(),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!widget.keyboardIsVisible)
                        FormHeaderSignUp(
                          color: Theme.of(context).primaryColor,
                          title: 'loginpage_login_form'.tr,
                          formController: formController,
                          settingsController: settingsController,
                        ),
                      SettingsBox(settingsFrameHeight: settingsFrameHeight),
                      LoginTextForms(formFrameHeight: formFrameHeight),
                      LoginSubmitButton(),
                      ButtonsDivider(orLineAlterHeight: orLineAlterHeight),
                      OrDivider(orLineHeight: orLineHeight),
                      ButtonModel(
                        text: 'loginpage_login_with_google'.tr,
                        onPressed: formController.value == 0.0 ? null : () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
