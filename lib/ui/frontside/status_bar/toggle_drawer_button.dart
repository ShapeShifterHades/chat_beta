import 'package:flutter/material.dart';

/// Button, that triggers drawer animation
class ToggleDrawerButton extends StatelessWidget {
  /// Controller to trigger animation
  final AnimationController animationController;
  ToggleDrawerButton({
    Key key,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomPaint(
        painter: MenuButtonPainter(context),
        child: GestureDetector(
          onTap: () {
            animationController.isCompleted
                ? animationController.reverse()
                : animationController.forward();
          },
          child: Container(
            color: Colors.transparent,
            width: 40,
            height: 40,
            padding: EdgeInsets.all(4.5),
            child: Container(
              margin: EdgeInsets.all(5.5),
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: animationController,
                semanticLabel: 'Show menu',
                size: 20,
                color: Theme.of(context).primaryColor,
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
    Path path1 = Path();
    Path path2 = Path();
    Path path3 = Path();
    Path path4 = Path();

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

    path4.moveTo(size.width - 8, size.height);
    path4.lineTo(size.width, size.height - 8);
    path4.lineTo(size.width, size.height);
    path4.lineTo(size.width, size.height);
    path4.close();

    Paint paint4 = Paint()
      ..style = PaintingStyle.fill
      ..color = Theme.of(context).backgroundColor;

    canvas.drawPath(path4, paint4);

    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = Theme.of(context).scaffoldBackgroundColor;

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round
      ..color = Theme.of(context).primaryColor;

    canvas.drawPath(path2, paint2);

    Paint paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round
      ..color = Theme.of(context).primaryColor;

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
