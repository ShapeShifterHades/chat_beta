import 'package:flutter/material.dart';

class CustomPainterForClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path2 = Path();

    path2.lineTo(0, size.height);
    path2.lineTo(size.width * 0.85, size.height);
    path2.lineTo(size.width, size.height * 0.8);
    path2.lineTo(size.width, 0);

    path2.close();

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Colors.black;

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
