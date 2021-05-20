import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

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
            const _MessagesIcon(),
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

class _MessagesIcon extends StatelessWidget {
  const _MessagesIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isChatrooms =
        ModalRoute.of(context)?.settings.name == chatRoute;
    return AnimatedSwitcher(
      duration: Times.slower,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: !_isChatrooms
          ? MiniMenuTile(
              key: const Key('chatrooms_minimenu_buton'),
              func: () => Navigator.of(context).pushNamed(homeRoute),
              icon: Icons.message,
              isCurrentPage:
                  ModalRoute.of(context)?.settings.name == homeRoute ||
                      ModalRoute.of(context)?.settings.name == initialRoute,
            )
          : const _InDialogMenuTile(),
    );
  }
}

class _InDialogMenuTile extends StatelessWidget {
  const _InDialogMenuTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MiniMenuTile(
      key: const Key('dialog_minimenu_buton'),
      func: () => Navigator.of(context).pushNamed(homeRoute),
      icon: Icons.question_answer,
      isCurrentPage: ModalRoute.of(context)?.settings.name == chatRoute,
    );
  }
}
