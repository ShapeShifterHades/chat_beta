import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/searchbar/user_search.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tabs_content/pendinglist_content.dart';

import 'tabs_content/friendlist_content.dart';

class ContactPageTabsContent extends StatelessWidget {
  const ContactPageTabsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            UserSearch(),
            _UserList(),
          ],
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  const _UserList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactTabsBloc, ContactTabsState>(
        bloc: BlocProvider.of<ContactTabsBloc>(context),
        builder: (context, state) {
          if (state is FriendlistState) {
            return const FriendlistContent();
          }
          if (state is PendinglistState) {
            return PendinglistContent();
          }
          return const _ContactsLoadingIndication();
        });
  }
}

class _ContactsLoadingIndication extends StatelessWidget {
  const _ContactsLoadingIndication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).contacts_loading,
        style: TextStyles.body1,
      ),
    );
  }
}
