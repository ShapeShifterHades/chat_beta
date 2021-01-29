import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mini_menu_tile.dart';

class MiniMenu extends StatelessWidget {
  const MiniMenu({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 40 - size.width * 0.01,
      child: Container(
        width: 50,
        height: 490,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MiniMenuTile(
              isCurrentPage: Get.arguments == 'Messages',
              key: Key('messages_minimenu_buton'),
              func: () {
                Get.toNamed("/messages", arguments: 'Messages');
              },
              icon: Icons.message,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              isCurrentPage: Get.arguments == 'Contacts',
              key: Key('contacts_minimenu_buton'),
              func: () {
                Get.toNamed("/contacts", arguments: 'Contacts');
              },
              icon: Icons.contacts,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              isCurrentPage: Get.arguments == 'Settings',
              key: Key('settings_minimenu_buton'),
              func: () {
                Get.toNamed("/settings", arguments: 'Settings');
              },
              icon: Icons.settings,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              isCurrentPage: Get.arguments == 'Security',
              key: Key('security_minimenu_buton'),
              func: () {
                Get.toNamed("/security", arguments: 'Security');
              },
              icon: Icons.lock,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              isCurrentPage: Get.arguments == 'FAQ',
              key: Key('faq_minimenu_buton'),
              func: () {
                Get.toNamed("/faq", arguments: 'FAQ');
              },
              icon: Icons.help,
            ),
            SizedBox(height: 45),
            MiniMenuTile(
              func: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icons.logout,
            ),
            SizedBox(height: 85),
          ],
        ),
      ),
    );
  }
}
