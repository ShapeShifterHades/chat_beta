import 'package:flutter/material.dart';

class CustomPainterForClipper extends CustomPainter {
  final Color color;

  CustomPainterForClipper({this.color = const Color(0xFFA7F5FF)});
  @override
  void paint(Canvas canvas, Size size) {
    Path path2 = Path();

    path2.moveTo(0, 30);
    path2.lineTo(0, size.height);
    path2.lineTo(size.width - 30, size.height);
    path2.lineTo(size.width, size.height - 30);
    path2.lineTo(size.width, 0);
    path2.lineTo(30, 0);
    path2.quadraticBezierTo(0, 0, 0, 30);

    path2.close();

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = color;

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
