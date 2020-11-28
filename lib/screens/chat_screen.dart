import 'package:flutter/material.dart';
import 'package:void_chat_beta/widgets/build_app_bar.dart';
import 'package:void_chat_beta/widgets/chat/messages.dart';
import 'package:void_chat_beta/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
