import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/login/widgets/main_frame/formfields/password_input.dart';

import 'formfields/email_input.dart';
import 'constants.dart';

class LoginTextForms extends StatelessWidget {
  const LoginTextForms({
    Key key,
    @required this.formFrameHeight,
  }) : super(key: key);

  final Animation<double> formFrameHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: formFrameHeight.value,
      width: Get.size.width * 0.9,
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: buildFormFieldBackground(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: EmailInput(), // _buildEmailTextField(context),
            ),
            Container(
              height: 80,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: PasswordInput(), //_buildPasswordTextField(context),
            ),
          ],
        ),
      ),
    );
  }
}

// class _LoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 key: const Key('loginForm_continue_raisedButton'),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   primary: const Color(0xFFFFD600),
//                 ),
//                 child: const Text('LOGIN'),
//                 onPressed: state.status.isValidated
//                     ? () => context.read<LoginCubit>().logInWithCredentials()
//                     : null,
//               );
//       },
//     );
//   }
// }

// class _GoogleLoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ElevatedButton.icon(
//       key: const Key('loginForm_googleLogin_raisedButton'),
//       label: const Text(
//         'SIGN IN WITH GOOGLE',
//         style: TextStyle(color: Colors.white),
//       ),
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         primary: theme.accentColor,
//       ),
//       icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
//       onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
//     );
//   }
// }
