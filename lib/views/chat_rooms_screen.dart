import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/helper/authenticate.dart';
import 'package:void_chat_beta/helper/constants.dart';
import 'package:void_chat_beta/helper/helper_functions.dart';
import 'package:void_chat_beta/services/auth.dart';
import 'package:void_chat_beta/services/database.dart';

import 'search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

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
                    userName: snapshot.data.documents[index].data['chatroomId'],
                  );
                })
            : Container(color: Colors.amber);
      },
    );
  }

  getUserInfo() async {
    Constants.kMyName = await HelperFunctions.getUserNameSharedPreference();

    databaseMethods.getChatRooms(Constants.kMyName).then((val) {
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
  final String userName;

  ChatRoomsTile({this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              userName.substring(0, 1).toUpperCase(),
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
    );
  }
}
