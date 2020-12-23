import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/constants/constants.dart';

class DrawerMenuPMTile extends StatefulWidget {
  final String text;

  const DrawerMenuPMTile({Key key, this.text}) : super(key: key);

  @override
  _DrawerMenuPMTileState createState() => _DrawerMenuPMTileState();
}

class _DrawerMenuPMTileState extends State<DrawerMenuPMTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        GestureDetector(
          onTapCancel: () {
            setState(() {
              _pressed = false;
            });
          },
          onTapUp: (val) {
            setState(() {
              _pressed = false;
            });
          },
          onTapDown: (val) {
            setState(() {
              _pressed = true;
            });
          },
          child: CustomPaint(
            painter: DrawerMenuPMTilePainter(pressed: _pressed),
            child: ClipPath(
              clipper: DrawerMenuPMTileClipper(),
              child: Container(
                color: _pressed ? kABitBlack.withOpacity(0.5) : kABitBlack,
                width: 140,
                height: 32,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(flex: 4),
                      Text(
                        'Settings',
                        style: GoogleFonts.jura(
                            color: _pressed
                                ? kStrokeColor.withOpacity(0.5)
                                : kStrokeColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DrawerMenuPMTilePainter extends CustomPainter {
  final bool pressed;

  DrawerMenuPMTilePainter({this.pressed = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = pressed ? kStrokeColor.withOpacity(0.5) : kStrokeColor;

    Path path1 = Path();
    path1.lineTo(size.width * 0.15, 0);
    path1.moveTo(size.width * 0.85, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.15);
    path1.moveTo(size.width, size.height - 8);
    path1.lineTo(size.width - 8, size.height);
    path1.lineTo(size.width * 0.85, size.height);
    path1.moveTo(size.width * 0.15, size.height);
    path1.lineTo(0, size.height);
    path1.lineTo(0, size.height * 0.85);
    path1.moveTo(0, size.height * 0.15);
    path1.lineTo(0, 0);

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = kMainFrameColor;

    Path path2 = Path();

    path2.lineTo(0, size.height);
    path2.lineTo(size.width - 8, size.height);
    path2.lineTo(size.width, size.height - 8);
    path2.lineTo(size.width, 0);
    path2.close();

    // canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DrawerMenuPMTileClipper extends CustomClipper<Path> {
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
