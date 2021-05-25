import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

class ExitMiniMenuTile extends StatelessWidget {
  const ExitMiniMenuTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationLogoutRequested()),
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
          painter: ExitMiniMenuTilePainter(
              pressed: null, color: Theme.of(context).primaryColor),
          child: ClipPath(
            clipper: ExitMiniMenuTileClipper(),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.08),
              width: 34,
              height: 38,
              child: Center(
                child: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExitMiniMenuTilePainter extends CustomPainter {
  final Color? color;

  final bool? pressed;

  ExitMiniMenuTilePainter({this.color, this.pressed = false});

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

class ExitMiniMenuTileClipper extends CustomClipper<Path> {
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
