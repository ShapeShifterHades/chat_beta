import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/login/widgets/main_frame/formfields/email_input.dart';
import 'package:void_chat_beta/login/widgets/main_frame/formfields/password_input.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/textfields/confirm_password_input.dart';
import 'package:void_chat_beta/signup/widgets/textfields/username_input.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';

class TextfieldsFrame extends StatelessWidget {
  const TextfieldsFrame({
    Key key,
    @required this.formFrameHeight,
  }) : super(key: key);

  final Animation<double> formFrameHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: formFrameHeight.value,
      width: Get.size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: buildFormBackground3(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: ClipPath(clipper: ScreenTagClipper(), child: EmailInput()),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: PasswordInput(),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: ConfirmPasswordInput(),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: UsernameInput(),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Container(child: Text('License here')),
            ),
          ],
        ),
      ),
    );
  }
}

// class _SignUpButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 key: const Key('signUpForm_continue_raisedButton'),
//                 child: const Text('SIGN UP'),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   primary: Colors.orangeAccent,
//                 ),
//                 onPressed: state.status.isValidated
//                     ? () => context.read<SignUpCubit>().signUpFormSubmitted()
//                     : null,
//               );
//       },
//     );
//   }
// }
