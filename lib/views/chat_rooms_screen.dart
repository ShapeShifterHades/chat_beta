import 'package:flutter/material.dart';
import 'package:void_chat_beta/helper/authenticate.dart';
import 'package:void_chat_beta/helper/constants.dart';
import 'package:void_chat_beta/helper/internal_database_functions.dart';
import 'package:void_chat_beta/services/firebase_auth.dart';
import 'package:void_chat_beta/services/firebase_data_methods.dart';

import 'conversation_screen.dart';
import 'search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  HelperFunctions helperFunctions = HelperFunctions();

  Stream chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    chatRoomId: snapshot.data.documents[0]['chatRoomId'],
                    userName: snapshot.data.documents[0]['chatRoomId']
                        .toString()
                        .replaceAll('_', '')
                        .replaceAll(Constants.kMyName, ''),
                  );
                })
            : Container(color: Colors.amber);
      },
    );
  }

  getUserInfo() async {
    Constants.kMyName = await helperFunctions.getUsersName();

    databaseMethods.getChatRoomsStream(Constants.kMyName).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
      appBar: AppBar(
        title: Text('Void Chat app'),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String chatRoomId;
  final String userName;

  ChatRoomsTile({this.userName, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                userName.substring(0, 1).toUpperCase(),
                style: TextStyle(color: kMainTextColor),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: TextStyle(color: kMainTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
