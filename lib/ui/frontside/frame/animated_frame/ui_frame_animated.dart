import 'package:flutter/material.dart';

import 'ui_painter.dart';

class UiFullFrameAnimated extends StatelessWidget {
  const UiFullFrameAnimated({
    Key key,
    @required this.context,
    this.size,
  }) : super(key: key);

  final BuildContext context;
  final Size size;

  @override
  Widget build(BuildContext ctx) {
    return CustomPaint(
      painter: UiPainter(
        context: context,
      ),
      child: Container(),
    );
  }
}
