import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/screens/chatlist_screen.dart';
import 'package:void_chat_beta/screens/contacts_screen.dart';

import 'auth/firebase_core_init.dart';

AppBar buildAppBar(BuildContext context, {String title = 'Void Chat'}) {
  return AppBar(
    title: Text(title),
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
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.search_sharp),
                  SizedBox(width: 8),
                  Text('Find a user'),
                ],
              ),
            ),
            value: 'finduser',
          ),
        ],
        onChanged: (itemidentifier) async {
          if (itemidentifier == 'logout') {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FirebaseCoreInit(),
                ));
          }
          if (itemidentifier == 'chatlists') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatlistScreen(),
              ),
            );
          }
          if (itemidentifier == 'finduser') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FindUserScreen(),
              ),
            );
          }
        },
      )
    ],
  );
}
