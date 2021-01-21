import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'chevron_right.dart';

class AuthenticateFormHeader extends StatefulWidget {
  const AuthenticateFormHeader({
    Key key,
  }) : super(key: key);

  @override
  _AuthenticateFormHeaderState createState() => _AuthenticateFormHeaderState();
}

bool isPressed = false;

class _AuthenticateFormHeaderState extends State<AuthenticateFormHeader> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.watch<LoginCubit>().state.status.isValidated
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      onPanDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onPanCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onPanEnd: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        height: 80,
        width: double.infinity,
        color: Theme.of(context).highlightColor,
        child: Center(
          child: Shimmer.fromColors(
            baseColor: isPressed ? Colors.white70 : kMainBgColor,
            highlightColor: Theme.of(context).primaryColor,
            direction: ShimmerDirection.ltr,
            loop: 1,
            period: Duration(milliseconds: 700),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                ChevronRight(
                    offset: Offset(-10, -35),
                    color: isPressed ? Colors.white70 : kMainBgColor),
                Text(
                  'AUTHENTICATE',
                  style: GoogleFonts.jura(
                    color: isPressed ? Colors.white70 : kMainBgColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                ChevronRight(
                    offset: Offset(8, -35),
                    color: isPressed ? Colors.white70 : kMainBgColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
