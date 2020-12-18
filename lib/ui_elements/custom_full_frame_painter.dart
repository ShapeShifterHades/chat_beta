import 'package:flutter/material.dart';

import '../constants.dart';

class CustomFullFramePainter extends CustomPainter {
  double animTopVal;
  double animBotVal;
  double animrightVal;
  double animLeftVal;
  double animAngle;

  final Color color = kMainTextColor;
  CustomFullFramePainter({
    this.animTopVal,
    this.animrightVal,
    this.animBotVal,
    this.animLeftVal,
    this.animAngle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var _anglePaint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    Offset angleStartingPoint = Offset(size.width, size.height - animAngle);
    Offset angleEndingPoint = Offset(size.width - animAngle, size.height);

    canvas.drawLine(angleStartingPoint, angleEndingPoint, _anglePaint);

    var _topPaint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    Offset topStartingPoint = Offset(0, 0);
    Offset topEndingPoint = Offset(animTopVal, 0);

    canvas.drawLine(topStartingPoint, topEndingPoint, _topPaint);

    var _bottomPaint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    Offset bottomStartingPoint = Offset(size.width - 30, size.height);
    Offset bottomEndingPoint = Offset(size.width - animBotVal, size.height);

    canvas.drawLine(bottomStartingPoint, bottomEndingPoint, _bottomPaint);

    var _rightPaint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    Offset rightStartingPoint = Offset(size.width, 0);
    Offset rightEndingPoint = Offset(size.width, animrightVal);

    canvas.drawLine(rightStartingPoint, rightEndingPoint, _rightPaint);

    var _leftPaint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    Offset leftStartingPoint = Offset(0, size.height);
    Offset leftEndingPoint = Offset(0, size.height - animLeftVal);

    canvas.drawLine(leftStartingPoint, leftEndingPoint, _leftPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
