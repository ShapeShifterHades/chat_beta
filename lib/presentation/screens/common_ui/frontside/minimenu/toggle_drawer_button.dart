import 'package:flutter/material.dart';

/// Button, that triggers drawer animation
class ToggleDrawerButton extends StatelessWidget {
  /// Controller to trigger animation
  final AnimationController? animationController;
  ToggleDrawerButton({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      // top: MediaQuery.of(context).size.width * 0.05 + 30,
      child: GestureDetector(
        onTap: () {
          animationController!.isCompleted
              ? animationController!.reverse()
              : animationController!.forward();
        },
        child: CustomPaint(
          painter: MenuButtonPainter(context),
          child: ClipPath(
            clipper: MenuButtonClipper(),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 40,
              height: 40,
              padding: EdgeInsets.all(5),
              child: Container(
                margin: EdgeInsets.all(5.5),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animationController!,
                  semanticLabel: 'Show menu',
                  size: 21,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButtonPainter extends CustomPainter {
  final BuildContext context;

  MenuButtonPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;

    Path path = Path()
      ..moveTo(14, sh)
      ..lineTo(sw - 10, sh)
      ..lineTo(sw, sh - 10)
      ..lineTo(sw, 5);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4
      ..strokeCap = StrokeCap.round
      ..color = Theme.of(context).primaryColor;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MenuButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double sh = size.height;
    double sw = size.width;

    Path path = Path()
      ..lineTo(0, sh)
      ..lineTo(sw - 10, sh)
      ..lineTo(sw, sh - 10)
      ..lineTo(sw, 0)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
