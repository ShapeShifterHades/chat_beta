import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessageList extends StatefulWidget {
  final String myId;
  final String myUsername;
  final String userId;
  final String username;

  const MessageList({
    Key key,
    this.myId,
    this.myUsername,
    this.userId,
    this.username,
  }) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(widget.myId)
            .collection(widget.userId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          print(chatSnapshot.data.documents.isEmpty);
          if (chatSnapshot.data.documents.isEmpty) {
            return Center(
              child: Text('No messages yet'),
            );
          }
          var chatDocs = chatSnapshot.data.documents.get('chatContent');
          return ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['from'],
                chatDocs[index]['from'] == widget.myUsername,
                // chatDocs[index]['userId'] == futureSnapshot.data.uid,
                key: ValueKey(index)),
            itemCount: chatDocs.length,
          );
        });
  }
}
