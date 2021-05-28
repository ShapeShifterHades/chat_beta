import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class DialogButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? callback;
  const DialogButton({
    Key? key,
    this.callback,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      autofocus: true,
      onPressed: callback ?? () {},
      child: child ??
          Text(
            'text',
            style: TextStyles.body1
                .copyWith(color: Theme.of(context).backgroundColor),
          ),
    );
  }
}
