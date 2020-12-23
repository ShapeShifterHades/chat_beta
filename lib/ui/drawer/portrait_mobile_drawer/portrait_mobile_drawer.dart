import 'package:cloud_firestore/cloud_firestore.dart';
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
            duration: Duration(milliseconds: 700),
            opacity: widget.controller.value > 0.9 ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(
                  flex: 5,
                ),
                widget.controller.value > 0.6
                    ? DrawerMenuPMTile(
                        text: 'Messages',
                        iconData: Icons.message_outlined,
                      )
                    : Container(),
                SizedBox(height: 30),
                widget.controller.value > 0.6
                    ? DrawerMenuPMTile(
                        text: 'Contacts',
                        iconData: Icons.contacts_outlined,
                      )
                    : Container(),
                SizedBox(height: 30),
                widget.controller.value > 0.6
                    ? DrawerMenuPMTile(
                        text: 'Settings',
                        iconData: Icons.settings_applications_outlined,
                      )
                    : Container(),
                SizedBox(height: 30),
                widget.controller.value > 0.6
                    ? DrawerMenuPMTile(
                        text: 'Account',
                        iconData: Icons.account_circle_outlined,
                      )
                    : Container(),
                SizedBox(height: 30),
                widget.controller.value > 0.6
                    ? DrawerMenuPMTile(
                        text: 'FAQ',
                        iconData: Icons.menu_book_outlined,
                      )
                    : Container(),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
