import 'package:flutter/material.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/frontside/minimenu/exit_minimenu_tile.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/frontside/minimenu/messages_menu_tile.dart';

import 'mini_menu_tile.dart';

class MiniMenu extends StatelessWidget {
  const MiniMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -3,
      bottom: 125,
      child: SizedBox(
        width: 50,
        height: 490,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            MessagesIcon(),
            SizedBox(height: 15),
            MiniMenuTile(
              key: Key('contacts_minimenu_buton'),
              view: CurrentView.contacts,
              icon: Icons.contacts,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              key: Key('settings_minimenu_buton'),
              view: CurrentView.settings,
              icon: Icons.settings,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              key: Key('security_minimenu_buton'),
              view: CurrentView.security,
              icon: Icons.lock,
            ),
            SizedBox(height: 15),
            MiniMenuTile(
              key: Key('faq_minimenu_buton'),
              view: CurrentView.faq,
              icon: Icons.help,
            ),
            SizedBox(height: 45),
            ExitMiniMenuTile(),
          ],
        ),
      ),
    );
  }
}
