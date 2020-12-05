import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/screens/conversation_screen.dart';
import 'package:void_chat_beta/widgets/build_app_bar.dart';

class ChatlistScreen extends StatelessWidget {
  Future<User> getName() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Chatlist'),
      body: FutureBuilder(
          future: getName(),
          builder: (context, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(futureSnapshot.data.uid)
                    .collection('chatsList')
                    .snapshots(),
                builder: (context, chatBriefSnapshot) {
                  if (chatBriefSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final listItem = chatBriefSnapshot.data.documents;
                  return ListView.builder(
                    itemCount: listItem.length,
                    itemBuilder: (context, index) => Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.blueGrey,
                          child: ListTile(
                            key: Key(listItem[index].documentID),
                            leading: Icon(Icons.person),
                            title: Text(
                              listItem[index].documentID.toString(),
                            ),
                            subtitle: Text(
                              '${listItem[index]['lastMessageBy']}: ' +
                                  listItem[index]['lastMessage'].toString(),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConversationScreen(
                                    userId: listItem[index].documentID),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
