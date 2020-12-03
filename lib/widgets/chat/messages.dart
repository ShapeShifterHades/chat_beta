import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_chat_beta/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  final String opponentId;

  Messages({this.opponentId});

  Future<User> getName() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getName(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(futureSnapshot.data.uid)
                .collection('chat')
                .doc(opponentId)
                // .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.get('chatContent');
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['from'],
                    chatDocs[index]['from'] == 'You',
                    // chatDocs[index]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(index)),
                itemCount: chatDocs.length,
              );
            });
      },
    );
  }
}
