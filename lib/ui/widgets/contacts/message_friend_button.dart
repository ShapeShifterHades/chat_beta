import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/ui_screens/chat_screen.dart';

class MessageFriendButton extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapShot;
  final String myId;
  final String myUsername;
  final String userId;
  final String username;
  final BuildContext context;
  const MessageFriendButton({
    Key key,
    this.snapShot,
    this.myId,
    this.myUsername,
    this.userId,
    this.username,
    this.context,
  }) : super(key: key);

  startConversation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          myId: myId,
          myUsername: myUsername,
          userId: userId,
          username: username,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(6),
      color: Colors.blue,
      onPressed: snapShot.data ? startConversation : null,
      child: Text('Message'),
    );
  }
}
