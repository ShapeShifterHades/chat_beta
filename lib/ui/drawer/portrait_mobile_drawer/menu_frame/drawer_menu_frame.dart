import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';

import 'menu_button_pm.dart';

class DrawerMenuFrame extends StatefulWidget {
  AnimationController controller;
  DrawerMenuFrame({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _DrawerMenuFrameState createState() => _DrawerMenuFrameState();
}

class _DrawerMenuFrameState extends State<DrawerMenuFrame> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 12,
          ),
          MenuButtonPM(widget: widget),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            color: Colors.white,
          ),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            color: Colors.white,
          ),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
