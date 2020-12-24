import 'package:flutter/material.dart';

import 'package:void_chat_beta/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTag extends StatelessWidget {
  final String routeName;
  const ScreenTag({
    Key key,
    this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: CustomPaint(
        painter: ScreenTagPainter(),
        child: ClipPath(
          clipper: ScreenTagClipper(),
          child: Container(
            color: kABitBlack,
            height: 36,
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      routeName ?? 'fuck you',
                      style:
                          GoogleFonts.jura(color: kStrokeColor, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenTagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path1 = Path();
    Path path2 = Path();

    path2.lineTo(0, size.height);
    path2.lineTo(size.width - 8, size.height);
    path2.lineTo(size.width, size.height - 8);
    path2.lineTo(size.width, 0);

    path2.close();

    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = kMainBgColor;

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = kMainFrameColor;

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ScreenTagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width - 8, size.height);
    path.lineTo(size.width, size.height - 8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
