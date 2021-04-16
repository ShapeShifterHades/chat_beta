import 'package:flutter/material.dart';
import 'package:void_chat_beta/styles.dart';

/// Represetation of an animated buttor for a drawer-side main menu.
class DrawerMenuButton extends StatefulWidget {
  /// State of a button, that represents current page it is and changes styling
  final bool isCurrentPage;

  /// Function to use onPress
  final Function func;

  ///  Text for button label
  final String label;

  /// Context for dynamic styling
  final BuildContext context;

  const DrawerMenuButton(
      {Key key,
      this.context,
      this.label,
      this.func,
      this.isCurrentPage = false})
      : super(key: key);

  @override
  _DrawerMenuButtonState createState() => _DrawerMenuButtonState();
}

class _DrawerMenuButtonState extends State<DrawerMenuButton> {
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
        widget.func();
      },
      onTapDown: (val) {
        setState(() {
          _pressed = true;
        });
      },
      child: AnimatedOpacity(
        duration: Times.fast,
        opacity: _pressed ? 0.4 : 1,
        child: Row(
          children: [
            CustomPaint(
              painter: DrawerMenuButtonPainter(
                  pressed: _pressed,
                  color: Theme.of(context).primaryColor,
                  current: widget.isCurrentPage),
              child: ClipPath(
                clipper: DrawerMenuButtonClipper(),
                child: Container(
                  width: 140,
                  height: 38,
                  padding: EdgeInsets.only(bottom: 6),
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          widget.label,
                          style: TextStyles.body1,
                          textAlign: TextAlign.left,
                        ),
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

/// Frame elements for [DrawerMenuButton].
class DrawerMenuButtonPainter extends CustomPainter {
  final bool pressed;
  final Color color;
  final bool current;

  DrawerMenuButtonPainter(
      {this.color, this.pressed = false, this.current = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = current ? 1.5 : 0.3
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(0.8);

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

/// Clipper for [DrawerMenuButton].
class DrawerMenuButtonClipper extends CustomClipper<Path> {
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
