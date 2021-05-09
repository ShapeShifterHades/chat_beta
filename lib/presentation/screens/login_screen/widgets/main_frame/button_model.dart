import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class ButtonModel extends StatelessWidget {
  final bool? enabled;
  final String text;
  final Function? onPressed;
  const ButtonModel({
    Key? key,
    required this.text,
    this.onPressed,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 54,
        padding: const EdgeInsets.only(bottom: 10),
        color: Theme.of(context).primaryColor,
        child: Text(text,
            style: TextStyles.body1
                .copyWith(color: Theme.of(context).backgroundColor)),
      ),
    );
  }
}
