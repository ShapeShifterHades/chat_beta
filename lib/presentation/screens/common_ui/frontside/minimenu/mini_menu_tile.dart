import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class MiniMenuTile extends StatefulWidget {
  final bool isCurrentPage;
  final IconData? icon;
  final Function? func;
  const MiniMenuTile({
    Key? key,
    this.icon,
    this.func,
    this.isCurrentPage = false,
  }) : super(key: key);

  @override
  _MiniMenuTileState createState() => _MiniMenuTileState();
}

class _MiniMenuTileState extends State<MiniMenuTile>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimation() {
    _controller = AnimationController(duration: Times.fast, vsync: this);
    _animation = Tween<double>(begin: 18, end: 28)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _executeAnimation(_controller, 200);
  }

  void _executeAnimation(AnimationController animation, int interval) {
    Future.delayed(Duration(milliseconds: interval), () {
      if (animation != null) {
        animation.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.func as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.04,
            ),
          ),
        ),
        child: CustomPaint(
          painter: MiniMenuTilePainter(
              pressed: null, color: Theme.of(context).primaryColor),
          child: ClipPath(
            clipper: MiniMenuTileClipper(),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.08),
              width: 34,
              height: 38,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Icon(
                      widget.icon,
                      color: widget.isCurrentPage
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.7),
                      size: widget.isCurrentPage ? _animation.value : 18,
                    );
                  },
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
  final Color? color;

  final bool? pressed;

  MiniMenuTilePainter({this.color, this.pressed = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..strokeCap = StrokeCap.round
      ..color = color!.withOpacity(0.8);

    final Path path1 = Path();
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
    final Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
