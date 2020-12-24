import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';

import 'drawer_menu_frame.dart';

class MenuButtonPM extends StatelessWidget {
  AnimationController animationController;
  MenuButtonPM({
    Key key,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MenuButtonPainter(),
      child: ClipPath(
        clipper: MenuButtonClipper(),
        child: Container(
          color: animationController.value > 0
              ? kABitBlack
              : kStrokeColor.withOpacity(0.75),
          width: 40,
          height: 40,
          padding: EdgeInsets.all(4),
          child: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              animationController.isCompleted
                  ? animationController.reverse()
                  : animationController.forward();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: animationController,
              semanticLabel: 'Show menu',
              size: 28,
              color: animationController.value > 0
                  ? kStrokeColor.withOpacity(0.75)
                  : kABitBlack,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path1 = Path();
    Path path2 = Path();
    Path path3 = Path();

    path1.lineTo(0, size.height);
    path1.moveTo(0, 0);
    path1.lineTo(size.width, 0);

    path2.moveTo(0, size.height);
    path2.lineTo(size.width - 8, size.height);
    path2.lineTo(size.width, size.height - 8);
    path2.lineTo(size.width, 0);

    path3.moveTo(size.width * 0.85, 0);
    path3.lineTo(size.width, 0);
    path3.lineTo(size.width, size.height * 0.15);
    path3.moveTo(size.width * 0.15, size.height);
    path3.lineTo(0, size.height);
    path3.lineTo(0, size.height * 0.85);

    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..color = kMainBgColor;

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..strokeCap = StrokeCap.round
      ..color = kMainFrameColor;

    canvas.drawPath(path2, paint2);

    Paint paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = kStrokeColor2;

    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MenuButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double _padding = 3;
    double _bez = 8;

    path.moveTo(_padding, _padding + _bez);
    path.lineTo(_padding, size.height - 2 * _padding);
    path.lineTo(size.width - 6 - 2 * _padding, size.height - 2 * _padding);
    path.lineTo(size.width - 2 * _padding, size.height - 6 - 2 * _padding);
    path.lineTo(size.width - 2 * _padding, _padding);
    path.lineTo(_padding + _bez, _padding);
    path.quadraticBezierTo(_padding, _padding, _padding, _padding + _bez);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
