import 'package:flutter/material.dart';

class UiPainter extends CustomPainter {
  BuildContext context;

  UiPainter({
    this.context,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path _bottomRightCornerPath = Path();
    Paint _bottomRightCorner = Paint()
      ..color = Theme.of(context).bottomAppBarColor
      ..style = PaintingStyle.fill;

    _bottomRightCornerPath.moveTo(size.width - 30, size.height);
    _bottomRightCornerPath.lineTo(size.width, size.height - 30);
    _bottomRightCornerPath.lineTo(size.width, size.height);
    _bottomRightCornerPath.close();

    canvas.drawPath(_bottomRightCornerPath, _bottomRightCorner);

    Paint _anglePaint = Paint()
      ..color = Theme.of(context).primaryTextTheme.bodyText1.color
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    Offset angleStartingPoint = Offset(size.width - 30, size.height);
    Offset angleEndingPoint = Offset(size.width, size.height - 30);

    canvas.drawLine(angleStartingPoint, angleEndingPoint, _anglePaint);

    Paint _topPaint = Paint()
      ..color = Theme.of(context).primaryTextTheme.bodyText1.color
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    Offset topStartingPoint = Offset(0, 0);
    Offset topEndingPoint = Offset(size.width, 0);

    canvas.drawLine(topStartingPoint, topEndingPoint, _topPaint);

    Paint _bottomPaint = Paint()
      ..color = Theme.of(context).primaryTextTheme.bodyText1.color
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    Offset bottomStartingPoint = Offset(size.width - 30, size.height);
    Offset bottomEndingPoint = Offset(0, size.height);

    canvas.drawLine(bottomStartingPoint, bottomEndingPoint, _bottomPaint);

    Paint _rightPaint = Paint()
      ..color = Theme.of(context).primaryTextTheme.bodyText1.color
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    Offset rightStartingPoint = Offset(size.width, 0);
    Offset rightEndingPoint = Offset(size.width, size.height - 30);

    canvas.drawLine(rightStartingPoint, rightEndingPoint, _rightPaint);

    Paint _leftPaint = Paint()
      ..color = Theme.of(context).primaryTextTheme.bodyText1.color
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round;

    Offset leftStartingPoint = Offset(0, size.height);
    Offset leftEndingPoint = Offset(0, 0);

    canvas.drawLine(leftStartingPoint, leftEndingPoint, _leftPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
