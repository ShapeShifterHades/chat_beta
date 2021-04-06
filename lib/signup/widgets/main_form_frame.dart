import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/settings_frame.dart';
import 'package:void_chat_beta/signup/widgets/signup_with_google.dart';
import 'package:void_chat_beta/signup/widgets/submit_button.dart';
import 'package:void_chat_beta/signup/widgets/textfields_frame.dart';

import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:supercharged/supercharged.dart';
import 'package:void_chat_beta/widgets/form_header_signup.dart';

import 'or_line.dart';

/// Widget that represents main part of the Signup View
class SignupMainFormFrame extends StatefulWidget {
  final bool keyboardIsVisible;
  SignupMainFormFrame({this.keyboardIsVisible});

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

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: buildFormBackground1(context),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          alignment:
              widget.keyboardIsVisible ? Alignment.topCenter : Alignment.center,
          child: Container(
            margin: buildFormMargin(),
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
                        title: 'signup_registration'.tr,
                        formController: formController,
                        settingsController: settingsController,
                      ),
                    SettingsFrame(settingsFrameHeight: settingsFrameHeight),
                    TextfieldsFrame(formFrameHeight: formFrameHeight),
                    SubmitButton(),
                    Container(
                      decoration: buildFormBackground4(context),
                      width: Get.size.width * 0.9,
                      height: orLineAlterHeight.value,
                    ),
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

//   Padding _buildLicenseAgreement(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 2.0),
//       child: CheckboxFieldBlocBuilder(
//         errorBuilder: (context, value) => 'signup_agree'.tr,
//         checkColor: Theme.of(context).primaryColor,
//         activeColor: Colors.transparent,
//         padding: EdgeInsets.all(2),
//         booleanFieldBloc: widget.loginFormBloc.showAgreementCheckbox,
//         body: Container(
//           clipBehavior: Clip.none,
//           child: Row(
//             children: [
//               Text(
//                 'signup_i_agree'.tr,
//                 style: GoogleFonts.jura(
//                     fontWeight: FontWeight.w300,
//                     fontSize: 12,
//                     color: Theme.of(context).primaryTextTheme.bodyText1.color),
//               ),
//               FlatButton(
//                 padding: EdgeInsets.all(5),
//                 onPressed: () {},
//                 child: Text(
//                   'signup_with_terms'.tr,
//                   style: GoogleFonts.jura(
//                     fontWeight: FontWeight.w300,
//                     fontSize: 14,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   TextFieldBlocBuilder _buildUsernameTextField(BuildContext context) {
//     return TextFieldBlocBuilder(
//       padding: EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 2),
//       isEnabled: true,
//       textFieldBloc: widget.loginFormBloc.username,
//       suffixButton: SuffixButton.asyncValidating,
//       cursorColor: Theme.of(context).primaryColor,
//       cursorWidth: 0.5,
//       decoration: InputDecoration(
//         fillColor: Theme.of(context).backgroundColor,
//         labelStyle: GoogleFonts.jura(
//           color: Theme.of(context).primaryColor,
//         ),
//         labelText: 'signup_username'.tr,
//         prefixIcon: Icon(
//           Icons.person_add_outlined,
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }

//   TextFieldBlocBuilder _buildConfirmPasswordTextFied(BuildContext context) {
//     return TextFieldBlocBuilder(
//       suffixButton: SuffixButton.obscureText,
//       obscureTextFalseIcon: Icon(
//         Icons.visibility_off_outlined,
//         color: Theme.of(context).primaryColor,
//       ),
//       obscureTextTrueIcon: Icon(
//         Icons.visibility_outlined,
//         color: Theme.of(context).primaryColor,
//       ),
//       padding: EdgeInsets.all(2),
//       isEnabled: true,
//       textFieldBloc: widget.loginFormBloc.confirmPassword,
//       cursorColor: Theme.of(context).primaryColor,
//       cursorWidth: 0.5,
//       decoration: InputDecoration(
//         fillColor: Theme.of(context).backgroundColor,
//         labelStyle: GoogleFonts.jura(
//           color: Theme.of(context).primaryColor,
//         ),
//         labelText: 'signup_confirm_password'.tr,
//         prefixIcon: Icon(
//           Icons.lock_outline,
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }

//   TextFieldBlocBuilder _buildPasswordTextField(BuildContext context) {
//     return TextFieldBlocBuilder(
//       padding: EdgeInsets.all(2),
//       textFieldBloc: widget.loginFormBloc.password,
//       suffixButton: SuffixButton.obscureText,
//       obscureTextFalseIcon: Icon(
//         Icons.visibility_off_outlined,
//         color: Theme.of(context).primaryColor,
//       ),
//       obscureTextTrueIcon: Icon(
//         Icons.visibility_outlined,
//         color: Theme.of(context).primaryColor,
//       ),
//       style: GoogleFonts.jura(
//           color: Theme.of(context).primaryTextTheme.bodyText1.color),
//       cursorColor: Theme.of(context).primaryColor,
//       cursorWidth: 0.5,
//       decoration: InputDecoration(
//         fillColor: Theme.of(context).backgroundColor,
//         labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
//         labelText: 'signup_password'.tr,
//         prefixIcon: Icon(
//           Icons.lock_outline,
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }

//   TextFieldBlocBuilder _buildEmailTextField(BuildContext context) {
//     return TextFieldBlocBuilder(
//       key: Key('signup_email_form_key'),
//       padding: EdgeInsets.all(2),
//       textFieldBloc: widget.loginFormBloc.email,
//       keyboardType: TextInputType.emailAddress,
//       style: GoogleFonts.jura(
//           color: Theme.of(context).primaryTextTheme.bodyText1.color),
//       cursorColor: Theme.of(context).primaryColor,
//       cursorWidth: 0.5,
//       decoration: InputDecoration(
//         fillColor: Theme.of(context).backgroundColor,
//         labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
//         labelText: 'signup_email'.tr,
//         prefixIcon: Icon(
//           Icons.mail_outline,
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }
// }

}
