import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/ui/ui_screens/chatlist_screen.dart';
import 'package:void_chat_beta/ui/ui_screens/contacts_screen.dart';

import 'drawer_menu_pm_tile.dart';

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
                    route: ChatlistScreen(),
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'Contacts',
                    iconData: Icons.contacts_outlined,
                    route: ContactsScreen(),
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'Settings',
                    iconData: Icons.settings_applications_outlined,
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'Account',
                    iconData: Icons.account_circle_outlined,
                  ),
                  SizedBox(height: 30),
                  DrawerMenuPMTile(
                    text: 'FAQ',
                    iconData: Icons.menu_book_outlined,
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
