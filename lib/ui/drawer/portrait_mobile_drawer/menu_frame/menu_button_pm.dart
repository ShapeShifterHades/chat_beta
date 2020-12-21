import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/ui/ui_base_elements/auth_custom_frame/portrait/custom_clip_path.dart';

import 'drawer_menu_frame.dart';

class MenuButtonPM extends StatelessWidget {
  const MenuButtonPM({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final DrawerMenuFrame widget;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MenuButtonPainter(),
      child: Container(
        padding: EdgeInsets.all(4),
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: widget.controller,
          semanticLabel: 'Show menu',
          size: 40,
          color: kStrokeColor2,
        ),
      ),
    );
  }
}

class MenuButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path2 = Path();

    path2.moveTo(0, 10);
    path2.lineTo(0, size.height);
    path2.lineTo(size.width - 10, size.height);
    path2.lineTo(size.width, size.height - 10);
    path2.lineTo(size.width, 0);
    path2.lineTo(10, 0);
    // path2.quadraticBezierTo(0, 0, 0, 10);

    path2.close();

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = kStrokeColor2;

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
