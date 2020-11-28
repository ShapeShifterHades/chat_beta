import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/screens/internal_chat_list.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text('Chat beta'),
    actions: [
      DropdownButton(
        underline: Container(),
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
            value: 'logout',
          ),
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.data_usage),
                  SizedBox(width: 8),
                  Text('Chatlists'),
                ],
              ),
            ),
            value: 'chatlists',
          ),
        ],
        onChanged: (itemidentifier) {
          if (itemidentifier == 'logout') {
            FirebaseAuth.instance.signOut();
          }
          if (itemidentifier == 'chatlists') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InternalChatList(),
                ));
          }
        },
      )
    ],
  );
}
