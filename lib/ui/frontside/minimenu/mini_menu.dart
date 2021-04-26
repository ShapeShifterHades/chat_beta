import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:void_chat_beta/constants.dart';
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
              key: Key('messages_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(homeRoute),
              icon: Icons.message,
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: Key('contacts_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(contactsRoute),
              icon: Icons.contacts,
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: Key('settings_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(settingsRoute),
              icon: Icons.settings,
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: Key('security_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(securityRoute),
              icon: Icons.lock,
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: Key('faq_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(faqRoute),
              icon: Icons.help,
            ),
            const SizedBox(height: 45),
            MiniMenuTile(
              func: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icons.logout,
            ),
            SizedBox(height: 85 + size.width * 0.01),
          ],
        ),
      ),
    );
  }
}
