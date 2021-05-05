import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/widgets/chatroom_card.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: UI(
        body: MessagesContent(),
      ),
    );
  }
}

class MessagesContent extends StatefulWidget {
  const MessagesContent({
    Key? key,
  }) : super(key: key);

  @override
  _MessagesContentState createState() => _MessagesContentState();
}

class _MessagesContentState extends State<MessagesContent> {
  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)?.settings.name);
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
