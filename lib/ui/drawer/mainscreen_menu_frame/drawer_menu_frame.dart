import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/drawer/mainscreen_menu_frame/screen_tag.dart';

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

class _DrawerMenuFrameState extends State<DrawerMenuFrame>
    with SingleTickerProviderStateMixin {
  AnimationController _frameController;
  Animation<double> _frameAnimation;

  @override
  void initState() {
    super.initState();
    _frameController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _frameAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_frameController);
  }

  @override
  void dispose() {
    _frameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _frameController.forward();
    return FadeTransition(
      opacity: _frameAnimation,
      child: Container(
        width: size.width * 0.9,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MenuButtonPM(widget: widget),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: ScreenTag(),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
