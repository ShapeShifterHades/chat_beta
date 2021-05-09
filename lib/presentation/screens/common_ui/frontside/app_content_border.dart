import 'package:flutter/material.dart';

class AppContentBorder extends CustomPainter {
  BuildContext? context;
  // TODO: redraw this panter to have sigle path and clipper

  AppContentBorder({
    this.context,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Path _bottomRightCornerPath = Path();
    final Paint _bottomRightCorner = Paint()
      // ..color = Theme.of(context!).scaffoldBackgroundColor
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    _bottomRightCornerPath.moveTo(size.width - 30, size.height);
    _bottomRightCornerPath.lineTo(size.width, size.height - 30);
    _bottomRightCornerPath.lineTo(size.width, size.height);
    _bottomRightCornerPath.close();

    canvas.drawPath(_bottomRightCornerPath, _bottomRightCorner);

    final Paint _anglePaint = Paint()
      ..color = Theme.of(context!).primaryColor
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    final Offset angleStartingPoint = Offset(size.width - 30, size.height);
    final Offset angleEndingPoint = Offset(size.width, size.height - 30);

    canvas.drawLine(angleStartingPoint, angleEndingPoint, _anglePaint);

    final Paint _topPaint = Paint()
      ..color = Theme.of(context!).primaryColor
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    const Offset topStartingPoint = Offset(0, 0);
    final Offset topEndingPoint = Offset(size.width, 0);

    canvas.drawLine(topStartingPoint, topEndingPoint, _topPaint);

    final Paint _bottomPaint = Paint()
      ..color = Theme.of(context!).primaryColor
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    final Offset bottomStartingPoint = Offset(size.width - 30, size.height);
    final Offset bottomEndingPoint = Offset(0, size.height);

    canvas.drawLine(bottomStartingPoint, bottomEndingPoint, _bottomPaint);

    final Paint _rightPaint = Paint()
      ..color = Theme.of(context!).primaryColor
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    final Offset rightStartingPoint = Offset(size.width, 0);
    final Offset rightEndingPoint = Offset(size.width, size.height - 30);

    canvas.drawLine(rightStartingPoint, rightEndingPoint, _rightPaint);

    final Paint _leftPaint = Paint()
      ..color = Theme.of(context!).primaryColor
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    final Offset leftStartingPoint = Offset(0, size.height);
    const Offset leftEndingPoint = Offset(0, 0);

    canvas.drawLine(leftStartingPoint, leftEndingPoint, _leftPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
