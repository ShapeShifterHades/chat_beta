import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/frontside/status_bar/screen_tag.dart';

class SimpleButtonOne extends StatelessWidget {
  final bool? enabled;
  final String text;
  final Function? onPressed;
  const SimpleButtonOne({
    Key? key,
    required this.text,
    this.onPressed,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ScreenTagClipper(),
      child: MaterialButton(
        disabledColor: Theme.of(context).backgroundColor,
        onPressed: onPressed as void Function()? ?? () {},
        highlightColor: Theme.of(context).backgroundColor.withOpacity(0.14),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(text,
              style: TextStyles.body1
                  .copyWith(color: Theme.of(context).backgroundColor)),
        ),
      ),
    );
  }
}
