import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTag extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  const ScreenTag({
    Key key,
    this.child,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScreenTagPainter(context: context),
      child: ClipPath(
        clipper: ScreenTagClipper(),
        child: Container(
          // color: Theme.of(context).primaryColor.withOpacity(0.08),
          // height: 36,
          child: child ??
              Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        Get.arguments ?? 'null',
                        style: GoogleFonts.jura(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .color,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

class ScreenTagPainter extends CustomPainter {
  final BuildContext context;
  final Color color;

  ScreenTagPainter({this.context, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path1 = Path();

    path1.lineTo(0, size.height - 8);
    path1.moveTo(0, 0);
    path1.lineTo(size.width - 8, 0);

    Path path2 = Path();

    path2.lineTo(0, size.height - 8);
    path2.lineTo(8, size.height);
    path2.lineTo(size.width, size.height);
    path2.lineTo(size.width, 8);
    path2.lineTo(size.width - 8, 0);
    path2.close();

    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.butt
      ..color = Theme.of(context).primaryTextTheme.bodyText1.color;

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2
      ..color = color ?? Theme.of(context).primaryTextTheme.bodyText1.color;

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

    path.lineTo(0, size.height - 8);
    path.lineTo(8, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 8);
    path.lineTo(size.width - 8, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
