import 'dart:ui';

import 'package:flutter/material.dart';

class ButtonsDivider extends StatelessWidget {
  const ButtonsDivider({
    Key key,
    @required this.orLineAlterHeight,
  }) : super(key: key);

  final Animation<double> orLineAlterHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.4),
            border: Border.symmetric(
              vertical:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.2),
            ),
          ),
          height: orLineAlterHeight.value,
        ),
      ),
    );
  }
}
