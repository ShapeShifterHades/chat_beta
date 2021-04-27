// ignore: implementation_imports
import 'package:firestore_repository/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:void_chat_beta/styles.dart';

import '../contact_item_initial.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class FriendlistContent extends StatelessWidget {
  FriendlistContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ContactBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoaded) {
            var sorted = state.contacts
                .where((element) => element.status!.contains('friend'))
                .toList();
            return Column(
              children: [
                _ContactsCounter(sorted: sorted),
                _Divider(),
                _FriendsListViewBuilder(sorted: sorted),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).primaryColor,
      thickness: 0.2,
    );
  }
}

class _FriendsListViewBuilder extends StatelessWidget {
  const _FriendsListViewBuilder({
    Key? key,
    required this.sorted,
  }) : super(key: key);

  final List<Contact> sorted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      shrinkWrap: true,
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        return ContactItem(
          sorted: sorted,
          index: index,
        );
      },
    );
  }
}

class _ContactsCounter extends StatelessWidget {
  const _ContactsCounter({
    Key? key,
    required this.sorted,
  }) : super(key: key);

  final List<Contact> sorted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          S.of(context)!.contacts_friends + ': ' + sorted.length.toString(),
          style: TextStyles.body1,
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
