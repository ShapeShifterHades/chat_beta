import 'package:flutter/material.dart';
import 'package:void_chat_beta/widgets/build_app_bar.dart';
import 'package:void_chat_beta/widgets/chat/messages.dart';
import 'package:void_chat_beta/widgets/chat/new_message.dart';

class ConversationScreen extends StatelessWidget {
  final String userId;

  ConversationScreen({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: userId),
      body: Container(
        color: Colors.cyanAccent,
        child: Column(
          children: [
            Expanded(
              child: Messages(
                opponentId: userId,
              ),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
