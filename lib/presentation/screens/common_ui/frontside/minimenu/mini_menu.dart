import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';

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
                const _MessagesIcon(),
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
                MiniMenuTile(
                  // view: () async {
                  //   await FirebaseAuth.instance.signOut();
                  // },
                  icon: Icons.logout,
                ),
                SizedBox(height: 85 + size.width * 0.01),
              ],
            ),
          );
        }));
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
              icon: Icons.message,
              isCurrentPage:
                  context.watch<MainAppBloc>().state is MainAppLoaded &&
                      (context.watch<MainAppBloc>().state as MainAppLoaded)
                              .currentView ==
                          CurrentView.messages,
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
      view: CurrentView.dialog,
      icon: Icons.question_answer,
      isCurrentPage: context.watch<MainAppBloc>().state is MainAppLoaded &&
          (context.watch<MainAppBloc>().state as MainAppLoaded).currentView ==
              CurrentView.dialog,
    );
  }
}
