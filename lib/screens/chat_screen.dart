import 'package:flutter/material.dart';
import 'package:void_chat_beta/widgets/build_app_bar.dart';
import 'package:void_chat_beta/widgets/chat/message_list.dart';

import 'package:void_chat_beta/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  final String myId;
  final String myUsername;
  final String userId;
  final String username;

  const ChatScreen({
    Key key,
    this.myId,
    this.myUsername,
    this.userId,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: username),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MessageList(
                myId: myId,
                myUsername: myUsername,
                userId: userId,
                username: username,
              ),
            ),
            NewMessage(
              myId: myId,
              myUsername: myUsername,
              userId: userId,
              username: username,
            ),
          ],
        ),
      ),
    );
  }
}
