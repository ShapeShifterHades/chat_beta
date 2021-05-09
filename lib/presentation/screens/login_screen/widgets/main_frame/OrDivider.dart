// ignore: file_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
    required this.orLineHeight,
  }) : super(key: key);

  final Animation<double>? orLineHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.4),
              border: Border.symmetric(
                vertical: BorderSide(
                    color: Theme.of(context).primaryColor, width: 0.2),
              ),
            ),
            height: orLineHeight!.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 0.4,
                    indent: 12,
                    endIndent: 12,
                  ),
                ),
                Text(
                  S.of(context).signup_or,
                  style: TextStyles.body2
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Expanded(
                    child: Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 0.4,
                  indent: 12,
                  endIndent: 12,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
