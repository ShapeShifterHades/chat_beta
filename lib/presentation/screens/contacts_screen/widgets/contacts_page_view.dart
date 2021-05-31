import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tabs_content/blocklist_content.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tabs_content/friendlist_content.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tabs_content/pendinglist_content.dart';

class ContactsPageView extends StatelessWidget {
  const ContactsPageView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (page) {
        switch (page) {
          case 0:
            context.read<ContactTabsBloc>().add(FriendlistClicked());
            break;
          case 1:
            context.read<ContactTabsBloc>().add(PendinglistClicked());
            break;
          case 2:
            context.read<ContactTabsBloc>().add(BlocklistClicked());
            break;
          default:
        }
      },
      controller: controller,
      children: [
        const FriendlistContent(),
        const PendinglistContent(),
        const BlocklistContent(),
      ],
    );
  }
}
