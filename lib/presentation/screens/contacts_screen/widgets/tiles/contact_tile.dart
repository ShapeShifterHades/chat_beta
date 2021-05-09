import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class ContactTile extends StatelessWidget {
  final String? id;
  final BuildContext? context;
  final Widget? child;

  const ContactTile({
    Key? key,
    this.child,
    this.id,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ContactTilePainter(context: context, id: id),
      child: ClipPath(
        // clipBehavior: Clip.hardEdge,

        clipper: ContactTileClipper(),
        child: Container(child: child),
      ),
    );
  }
}

class ContactTilePainter extends CustomPainter {
  final BuildContext? context;
  final Color? color;
  final String? id;

  ContactTilePainter({this.context, this.color, this.id});
  @override
  void paint(Canvas canvas, Size size) {
    final Path path1 = Path();

    path1.moveTo(size.width, size.height - 16);
    path1.lineTo(size.height / 2 + 31, size.height - 16);
    path1.quadraticBezierTo(
        size.height / 2 + 17, size.height, size.height / 2, size.height);
    path1.lineTo(size.width - 8, size.height);
    path1.lineTo(size.width, size.height - 8);
    path1.lineTo(size.width, size.height - 16);

    final Paint paint1 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..shader = ui.Gradient.linear(
        const Offset(0.0, 0.0),
        Offset(size.width, size.height),
        [
          Theme.of(context!).primaryColor,
          Theme.of(context!).primaryColor.withOpacity(0.5),
        ],
      )
      ..color = color ?? Theme.of(context!).primaryTextTheme.bodyText1!.color!;

    canvas.drawPath(path1, paint1);

    final Path path2 = Path();

    path2.moveTo(size.height / 2, 0);
    path2.quadraticBezierTo(2.5, 2.5, 0, size.height / 2);
    path2.quadraticBezierTo(
        2.5, size.height - 2.5, size.height / 2, size.height);
    path2.lineTo(size.width - 8, size.height);
    path2.lineTo(size.width, size.height - 8);

    path2.lineTo(size.width, 8);
    path2.lineTo(size.width - 8, 0);
    path2.lineTo(size.height / 2, 0);

    final Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..shader = ui.Gradient.linear(
        const Offset(0.0, 0.0),
        Offset(size.width, size.height),
        [
          Theme.of(context!).primaryColor,
          Theme.of(context!).primaryColor.withOpacity(0.5),
        ],
      )
      ..color = color ?? Theme.of(context!).primaryTextTheme.bodyText1!.color!;

    canvas.drawPath(path2, paint2);

    final textStyle = TextStyles.body2.copyWith(
      fontStyle: FontStyle.italic,
      color: Theme.of(context!).backgroundColor,
      fontSize: 11,
    );
    final idSpan = TextSpan(
      text: id,
      style: textStyle,
    );
    final idPainter = TextPainter(
      text: idSpan,
      textDirection: TextDirection.ltr,
    );
    idPainter.layout(
      minWidth: 50,
      maxWidth: size.width,
    );
    final offset = Offset(size.height / 2 + 30, size.height - 18);
    idPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ContactTileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(size.height / 2 - 6, 0);
    path.quadraticBezierTo(2.5, 2.5, 0, size.height / 2);
    path.quadraticBezierTo(
        2.5, size.height - 2.5, size.height / 2 - 6, size.height);
    path.lineTo(size.width - 8, size.height);
    path.lineTo(size.width, size.height - 8);
    path.lineTo(size.width, 8);

    path.lineTo(size.width - 8, 0);
    path.lineTo(size.height / 2, 0);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
