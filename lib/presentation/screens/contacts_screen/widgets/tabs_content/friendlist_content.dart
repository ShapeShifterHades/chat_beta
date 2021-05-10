// ignore: implementation_imports
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import '../contact_item_initial.dart';

class FriendlistContent extends StatelessWidget {
  const FriendlistContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ContactBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoaded) {
            final List<Contact> sorted = state.contacts
                .where((element) => element.status!.contains('friend'))
                .toList();
            return Column(
              children: [
                _ContactsCounter(sorted: sorted),
                const _Divider(),
                _FriendsListViewBuilder(sorted: sorted),
              ],
            );
          }
          return const CircularProgressIndicator();
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
  _FriendsListViewBuilder({
    Key? key,
    required this.sorted,
  }) : super(key: key);

  final List<Contact> sorted;
  final FirestoreChatroomRepository firestoreChatroomRepository =
      FirestoreChatroomRepository();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            BlocProvider.of<ChatroomBloc>(context).add(
              AddChatroom(
                Chatroom(id: sorted[index].id!),
              ),
            );
            final Chatroom args = await firestoreChatroomRepository.getChatroom(
                BlocProvider.of<AuthenticationBloc>(context).state.user.id,
                sorted[index].id!);
            Navigator.of(context).pushNamed(chatRoute, arguments: args);
          },
          child: ContactItem(
            sorted: sorted,
            index: index,
          ),
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
          '${S.of(context).contacts_friends}: ${sorted.length}',
          style: TextStyles.body1,
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
