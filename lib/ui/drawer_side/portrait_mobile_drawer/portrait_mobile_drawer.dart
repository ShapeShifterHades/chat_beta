import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/ui/ui_screens/chatlist_screen.dart';
import 'package:void_chat_beta/ui/ui_screens/contacts_screen.dart';

import 'widgets/drawer_menu_pm_tile.dart';

class DrawerPM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kMainBgColor,
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  DrawerMenuPMTile(
                    text: 'Messages',
                    iconData: Icons.inbox_outlined,
                    route: '/messages',
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'Contacts',
                    iconData: Icons.contacts_outlined,
                    route: '/contacts',
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'Settings',
                    iconData: Icons.settings_applications_outlined,
                    route: '/settings',
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'Security',
                    iconData: Icons.account_circle_outlined,
                    route: '/security',
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'FAQ',
                    iconData: Icons.menu_book_outlined,
                    route: '/faq',
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  DrawerMenuPMTile(
                    text: 'Logout',
                    iconData: Icons.logout,
                    route: '/logout',
                  ),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
