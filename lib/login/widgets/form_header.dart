import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/widgets/switch_auth_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:void_chat_beta/login/login.dart';

class FormHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.watch<LoginCubit>().state.status.isValidated
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      child: Container(
        height: 80,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                context.watch<LoginCubit>().state.status.isSubmissionInProgress
                    ? const CircularProgressIndicator()
                    : Text(
                        'LOGIN',
                        style: GoogleFonts.jura(
                          letterSpacing: 4,
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: kMainBgColor,
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                        textAlign: TextAlign.justify,
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
                  onTap: () {
                    Navigator.of(context).pushNamed<void>(signupRoute);
                  },
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      Navigator.of(context).pushNamed<void>(signupRoute);
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
                      text: 'SWITCH TO REGISTRATION',
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
