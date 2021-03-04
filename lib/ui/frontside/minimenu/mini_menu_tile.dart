import 'package:flutter/material.dart';

class MiniMenuTile extends StatelessWidget {
  final bool isCurrentPage;
  final IconData icon;
  final Function func;
  const MiniMenuTile({
    Key key,
    this.icon,
    this.func,
    this.isCurrentPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentPage
              ? Theme.of(context).backgroundColor
              : Theme.of(context).backgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: isCurrentPage
                  ? Theme.of(context).backgroundColor
                  : Theme.of(context).primaryTextTheme.bodyText1.color,
              width: 0.0,
            ),
          ),
        ),
        child: CustomPaint(
          painter: MiniMenuTilePainter(
              pressed: null,
              color: isCurrentPage
                  ? Colors.white
                  : Theme.of(context).primaryTextTheme.bodyText1.color),
          child: ClipPath(
            clipper: MiniMenuTileClipper(),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.08),
              width: 34,
              height: 38,
              child: Center(
                child: Icon(
                  icon,
                  color: isCurrentPage
                      ? Colors.white
                      : Theme.of(context).primaryTextTheme.bodyText1.color,
                  size: isCurrentPage ? 28 : 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MiniMenuTilePainter extends CustomPainter {
  final Color color;

  final bool pressed;

  MiniMenuTilePainter({this.color, this.pressed = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(0.8);

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

class MiniMenuTileClipper extends CustomClipper<Path> {
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
