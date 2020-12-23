import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';

import 'drawer_menu_pm_tile.dart';

class DrawerPM extends StatefulWidget {
  AnimationController controller;
  DrawerPM({
    Key key,
    this.controller,
  }) : super(key: key);
  @override
  _DrawerPMState createState() => _DrawerPMState();
}

class _DrawerPMState extends State<DrawerPM> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kMainBgColor,
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 800),
            opacity: widget.controller.value > 0.9 ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.controller.value > 0.6
                    ? DrawerMenuPMTile()
                    : Container(),
                widget.controller.value > 0.6
                    ? ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Favourites'),
                      )
                    : Container(),
                widget.controller.value > 0.6
                    ? ListTile(
                        leading: Icon(Icons.map),
                        title: Text('Map'),
                      )
                    : Container(),
                widget.controller.value > 0.6
                    ? ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      )
                    : Container(),
                widget.controller.value > 0.6
                    ? ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
