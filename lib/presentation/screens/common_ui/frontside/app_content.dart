import 'package:flutter/material.dart';

import 'app_content_border.dart';

class AppContent extends StatelessWidget {
  const AppContent({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ContentClipper(),
      child: Container(
        color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.06,
          top: 5,
        ),
        child: CustomPaint(
            painter: AppContentBorder(
              context: context,
            ),
            child: child),
      ),
    );
  }
}

class ContentClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double sw = size.width;
    final double sh = size.height;
    final Path path = Path()
      ..lineTo(0, sh)
      ..lineTo(sw - 30, sh)
      ..lineTo(sw, sh - 30)
      ..lineTo(sw, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
