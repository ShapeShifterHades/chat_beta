import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';

class ChevronRight extends StatelessWidget {
  const ChevronRight({
    Key key,
    @required this.offset,
    this.color,
  }) : super(key: key);

  final Offset offset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Transform(
        transform: Matrix4.diagonal3Values(1.1, 4, 1),
        child: Icon(
          Icons.chevron_right,
          color: kMainBgColor,
        ),
      ),
    );
  }
}
