import 'package:flutter/material.dart';

class SearchUiPainter extends CustomPainter {
  final BuildContext context;
  final FocusNode focusNode;

  SearchUiPainter(this.context, this.focusNode);

  @override
  void paint(Canvas canvas, Size size) {
    double sw = size.width;
    double sh = size.height;
    Paint innerFramePaint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    Path innerFramePath = Path()
      ..lineTo(sw, sh)
      ..moveTo(sw, 0)
      ..lineTo(0, sh);

    canvas.drawPath(innerFramePath, innerFramePaint);

    Paint outerFramePaint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    Path outerFramePath = Path()
      ..lineTo(sw * 0.1, 0)
      ..moveTo(sw * 0.9, 0)
      ..lineTo(sw, 0)
      ..lineTo(sw, sh * 0.1)
      ..moveTo(sw, sh * 0.9)
      ..lineTo(sw, sh)
      ..lineTo(sw * 0.9, sh)
      ..moveTo(sw * 0.1, sh)
      ..lineTo(0, sh)
      ..lineTo(0, sh * 0.9)
      ..moveTo(0, sh * 0.1)
      ..lineTo(0, 0);

    if (focusNode.hasFocus) canvas.drawPath(outerFramePath, outerFramePaint);
  }

  @override
  bool shouldRepaint(SearchUiPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SearchUiPainter oldDelegate) => false;
}
