import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';

class ChatView extends StatelessWidget {
  final Chatroom? chat;

  const ChatView({Key? key, this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        body: Center(
          child: SizedBox.expand(
            child: Container(
              color: Colors.teal.withOpacity(0.2),
              child: Text(chat!.id!),
            ),
          ),
        ),
      ),
    );
  }
}
