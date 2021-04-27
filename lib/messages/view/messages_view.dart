import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/blocs/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/ui/ui.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatroomBloc(
            firestoreChatroomRepository:
                RepositoryProvider.of<FirestoreChatroomRepository>(context),
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

class ChatroomCard extends StatelessWidget {
  const ChatroomCard({
    Key? key,
    required this.chat,
    this.onPress,
  }) : super(key: key);

  final Chatroom chat;
  final VoidCallback? onPress;
  final bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6 * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  // backgroundImage: AssetImage(),
                ),
                if (isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(chat.lastMessageAt.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
