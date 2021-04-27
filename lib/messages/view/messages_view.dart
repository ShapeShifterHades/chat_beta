import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/blocs/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/messages/widgets/chatroom_card.dart';
import 'package:void_chat_beta/ui/ui.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatroomBloc(
            firestoreChatroomRepository:
                RepositoryProvider.of<FirestoreChatroomRepository?>(context),
          )..add(LoadChatrooms()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: UI(
          body: MessagesContent(),
        ),
      ),
    );
  }
}

class MessagesContent extends StatelessWidget {
  const MessagesContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatroomBloc, ChatroomState>(
      builder: (context, state) {
        if (state is ChatroomLoaded) {
          final chats = state.chatrooms;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              return ChatroomCard(
                chat: chats[index],
                onPress: () {},
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
