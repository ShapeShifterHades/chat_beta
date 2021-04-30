import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class SwitchToLogin extends StatelessWidget {
  const SwitchToLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(loginRoute),
        child: Container(
          alignment: Alignment.center,
          height: 60,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).primaryColor.withOpacity(0.5),
            highlightColor: Theme.of(context).primaryColor,
            loop: 0,
            period: Times.slower,
            child: Text(
              S.of(context).signup_switch_to_login,
              style: TextStyles.body1.copyWith(fontSize: 26),
            ),
          ),
        ),
      ),
    );
  }
}
