import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final Size size = MediaQuery.of(context).size;

    return Positioned(
        left: -3,
        bottom: 40 - size.width * 0.01,
        child:
            BlocBuilder<MainAppBloc, MainAppState>(builder: (context, state) {
          return SizedBox(
            width: 50,
            height: 490,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const MessagesIcon(),
                const SizedBox(height: 15),
                MiniMenuTile(
                  key: const Key('contacts_minimenu_buton'),
                  view: CurrentView.contacts,
                  icon: Icons.contacts,
                  isCurrentPage: state is MainAppLoaded &&
                      state.currentView == CurrentView.contacts,
                ),
                const SizedBox(height: 15),
                MiniMenuTile(
                  key: const Key('settings_minimenu_buton'),
                  view: CurrentView.settings,
                  icon: Icons.settings,
                  isCurrentPage: state is MainAppLoaded &&
                      state.currentView == CurrentView.settings,
                ),
                const SizedBox(height: 15),
                MiniMenuTile(
                  key: const Key('security_minimenu_buton'),
                  view: CurrentView.security,
                  icon: Icons.lock,
                  isCurrentPage: state is MainAppLoaded &&
                      state.currentView == CurrentView.security,
                ),
                const SizedBox(height: 15),
                MiniMenuTile(
                  key: const Key('faq_minimenu_buton'),
                  view: CurrentView.faq,
                  icon: Icons.help,
                  isCurrentPage: state is MainAppLoaded &&
                      state.currentView == CurrentView.faq,
                ),
                const SizedBox(height: 45),
                const ExitMiniMenuTile(),
                SizedBox(height: 85 + size.width * 0.01),
              ],
            ),
          );
        }));
  }
}
