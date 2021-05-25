import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/data/utils/safe_print.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class LoginSwitchButton extends StatelessWidget {
  final bool trigger;
  const LoginSwitchButton({
    Key? key,
    required this.trigger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    safePrint(Theme.of(context).primaryColor.toString());
    return Container(
        alignment: Alignment.center,
        height: 60,
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).primaryColor.withOpacity(0.5),
          highlightColor: Theme.of(context).primaryColor,
          period: Times.slower,
          child: AnimatedSwitcher(
            duration: Times.medium,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: trigger
                ? Text(S.of(context).loginpage_switch_to_registration,
                    key: const Key('switch_to_register'),
                    style: TextStyles.body1.copyWith(fontSize: 26))
                : Text(S.of(context).signup_switch_to_login,
                    key: const Key('switch_to_login'),
                    style: TextStyles.body1.copyWith(fontSize: 26)),
          ),
        ));
  }
}
