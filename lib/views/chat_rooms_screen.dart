import 'package:flutter/material.dart';
import 'package:void_chat_beta/widgets/appbar.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Void Chat app'),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
