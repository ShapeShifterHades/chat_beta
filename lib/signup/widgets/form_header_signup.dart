import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/widgets/switch_auth_button.dart';

import '../sign_up.dart';

class FormHeaderSignUp extends StatelessWidget {
  final Color color;
  final String title;

  const FormHeaderSignUp({
    Key key,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.watch<SignUpCubit>().state.status.isValidated
          ? () {
              FocusScope.of(context).unfocus();
              return context.read<SignUpCubit>().signUpFormSubmitted();
            }
          : null,
      child: Container(
        height: 80,
        width: double.infinity,
        color: color,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.jura(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: kMainBgColor,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.login_outlined,
                    color: Theme.of(context).backgroundColor, size: 36),
                SizedBox(width: 3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed<void>(loginRoute),
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      Navigator.of(context).pushNamed<void>(loginRoute);
                    }
                  },
                  child: Container(
                    height: 38,
                    width: 220,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                      ),
                    ),
                    child: SwitchAuthButton(
                      text: 'SWITCH TO LOGIN',
                    ),
                  ),
                ),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
