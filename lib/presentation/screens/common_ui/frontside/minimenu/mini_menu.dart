import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/constants.dart';

import 'mini_menu_tile.dart';

class MiniMenu extends StatelessWidget {
  const MiniMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      left: -3,
      bottom: 40 - size.width * 0.01,
      child: SizedBox(
        width: 50,
        height: 490,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                MiniMenuTile(
                  key: const Key('messages_minimenu_buton'),
                  func: () => Navigator.of(context).pushNamed(homeRoute),
                  icon: Icons.message,
                  isCurrentPage:
                      ModalRoute.of(context)?.settings.name == '/messages',
                ),
                if (ModalRoute.of(context)?.settings.name == chatRoute)
                  // TODO: make animated translation and rotation on init
                  Transform(
                      // rotationY(3.14159)..translate(2)
                      transform: Matrix4(
                        1,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                        24,
                        7,
                        0,
                        1,
                      )..rotateY(3.14159),
                      child: Icon(Icons.message,
                          color: Theme.of(context).primaryColor, size: 18)),
                // Container(color: Colors.red, width: 20, height: 20),
              ],
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: const Key('contacts_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(contactsRoute),
              icon: Icons.contacts,
              isCurrentPage:
                  ModalRoute.of(context)?.settings.name == '/contacts',
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: const Key('settings_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(settingsRoute),
              icon: Icons.settings,
              isCurrentPage:
                  ModalRoute.of(context)?.settings.name == '/settings',
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: const Key('security_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(securityRoute),
              icon: Icons.lock,
              isCurrentPage:
                  ModalRoute.of(context)?.settings.name == '/security',
            ),
            const SizedBox(height: 15),
            MiniMenuTile(
              key: const Key('faq_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(faqRoute),
              icon: Icons.help,
              isCurrentPage: ModalRoute.of(context)?.settings.name == '/faq',
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
