import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/constants/constants.dart';

class DrawerMenuPMTile extends StatefulWidget {
  final String route;
  final String text;
  final IconData iconData;

  const DrawerMenuPMTile({Key key, this.text, this.iconData, this.route})
      : super(key: key);

  @override
  _DrawerMenuPMTileState createState() => _DrawerMenuPMTileState();
}

class _DrawerMenuPMTileState extends State<DrawerMenuPMTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      onTapUp: (val) {
        setState(() {
          _pressed = false;
        });
        Navigator.pushNamed(
          context,
          widget.route ?? '/messages',
        );
      },
      onTapDown: (val) {
        setState(() {
          _pressed = true;
        });
      },
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: _pressed ? 0.4 : 1,
        child: Row(
          children: [
            SizedBox(width: 10),
            MenuItem(pressed: _pressed, widget: widget),
            SizedBox(width: 20),
            CustomPaint(
              painter: DrawerMenuPMTilePainter(pressed: _pressed),
              child: ClipPath(
                clipper: DrawerMenuPMTileClipper(),
                child: Container(
                  color: kABitBlack,
                  width: 140,
                  height: 32,
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(flex: 4),
                        Text(
                          widget.text,
                          style: GoogleFonts.jura(
                              color: kStrokeColor,
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
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key key,
    @required bool pressed,
    @required this.widget,
  })  : _pressed = pressed,
        super(key: key);

  final bool _pressed;
  final DrawerMenuPMTile widget;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IconMenuPMTilePainter(pressed: _pressed),
      child: ClipPath(
        clipper: IconMenuPMTileClipper(),
        child: Container(
          color: kABitBlack,
          width: 32,
          height: 32,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Icon(
                widget.iconData,
                color: kStrokeColor,
              ),
            ),
          ),
        ),
      ),
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
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = kStrokeColor.withOpacity(0.7);

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

class IconMenuPMTilePainter extends CustomPainter {
  final bool pressed;

  IconMenuPMTilePainter({this.pressed = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = kStrokeColor.withOpacity(0.7);

    Path path1 = Path();
    path1.lineTo(size.width * 0.15, 0);
    path1.moveTo(size.width * 0.85, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.15);
    path1.moveTo(size.width, size.height * 0.85);
    path1.lineTo(size.width, size.height);
    path1.lineTo(size.width * 0.85, size.height);

    path1.moveTo(size.width * 0.15, size.height);
    path1.lineTo(0, size.height);
    path1.lineTo(0, size.height * 0.85);
    path1.moveTo(0, size.height * 0.15);
    path1.lineTo(0, 0);

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class IconMenuPMTileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
