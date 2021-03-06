import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:formz/formz.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/form_header_signup.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/main_frame/buttons_divider.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/main_frame/or_divider.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/main_frame/settings_box.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/constants.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/textfields_frame.dart';
import 'package:void_chat_beta/presentation/styled_widgets/signup_submit_button.dart';
import 'package:void_chat_beta/presentation/styled_widgets/submit_ready_button.dart';

/// Widget that represents main part of the Signup View
class SignupMainFormFrame extends StatefulWidget {
  const SignupMainFormFrame({
    Key? key,
  }) : super(key: key);

  @override
  _SignupMainFormFrameState createState() => _SignupMainFormFrameState();
}

class _SignupMainFormFrameState extends State<SignupMainFormFrame>
    with AnimationMixin {
  /// Controller that is taking care of animation, is set to be played after widget first build
  AnimationController? formController;
  AnimationController? settingsController;

  Animation<double>? formFrameHeight;
  Animation<double>? settingsFrameHeight;
  Animation<double>? orLineHeight;
  Animation<double>? orLineAlterHeight;
  late bool isValid;

  // bool keyboardIsVisible = false;

  @override
  void initState() {
    formController = createController()
      ..play(duration: Times.fast)
      ..curve(Curves.easeInQuad);
    settingsController = createController();

    formFrameHeight = .0.tweenTo(310.0).animatedBy(formController!);
    settingsFrameHeight = .0.tweenTo(160.0).animatedBy(settingsController!);
    orLineHeight = .0.tweenTo(40.0).animatedBy(formController!);
    orLineAlterHeight = .0.tweenTo(40.0).animatedBy(settingsController!);
    isValid = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isValid = context.watch<SignUpCubit>().state.status.isValidated;
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final bool _isSubmitted =
            state.status == FormzStatus.submissionInProgress;

        return AnimatedAlign(
          duration: Times.fast,
          curve: Curves.easeIn,
          alignment: isKeyboardVisible ? Alignment.topCenter : Alignment.center,
          child: Container(
            margin: buildFormMargin(context),
            width: MediaQuery.of(context).size.width * .8,
            child: ClipPath(
              clipper: MainLoginFrameClipPath(),
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
                  AnimatedOpacity(
                    opacity: _isSubmitted ? .5 : 1,
                    duration: Times.fast,
                    child:
                        SettingsBox(settingsFrameHeight: settingsFrameHeight),
                  ),
                  AnimatedOpacity(
                    opacity: _isSubmitted ? .5 : 1,
                    duration: Times.fast,
                    child: TextfieldsFrame(formFrameHeight: formFrameHeight),
                  ),
                  SignUpSubmitButton(
                    func: isValid
                        ? () {
                            context.read<SignUpCubit>().signUpFormSubmitted();
                          }
                        : null,
                    submitErrorMessage: 'Error occured with provided data',
                  ),
                  AnimatedOpacity(
                    opacity: _isSubmitted ? .5 : 1,
                    duration: Times.fast,
                    child: ButtonsDivider(orLineAlterHeight: orLineAlterHeight),
                  ),
                  AnimatedOpacity(
                    opacity: _isSubmitted ? .5 : 1,
                    duration: Times.fast,
                    child: OrDivider(orLineHeight: orLineHeight),
                  ),
                  AnimatedOpacity(
                    opacity: _isSubmitted ? .5 : 1,
                    duration: Times.fast,
                    child: SubmitReadyButton(
                      submitText: S.of(context).signup_with_google,
                      func: formController!.value == 0.0 ? null : () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
