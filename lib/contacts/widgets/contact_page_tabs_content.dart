import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/blocs/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/tabs_content/pendinglist_content.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/user_search.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

import 'tabs_content/friendlist_content.dart';

class ContactPageTabsContent extends StatelessWidget {
  const ContactPageTabsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 32),
          child: Column(
            children: [
              UserSearch(),
              _UserList(),
            ],
          ),
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
            return FriendlistContent();
          }
          if (state is PendinglistState) {
            return PendinglistContent();
          }
          return _ContactsLoadingIndication();
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
