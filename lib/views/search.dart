import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/helper/constants.dart';
import 'package:void_chat_beta/services/database.dart';
import 'package:void_chat_beta/widgets/appbar.dart';
import 'package:void_chat_beta/widgets/searchList.dart';

import '../constants.dart';
import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatRoomAndStartConversation({String userName}) async {
    if (userName != Constants.kMyName) {
      String chatRoomId = await getChatRoomId(userName, Constants.kMyName);

      List<String> users = [userName, Constants.kMyName];
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatRoomId': chatRoomId
      };

      await DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[600],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchTextEditingController,
                      style: TextStyle(
                        color: kMainTextColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search username...',
                        hintStyle: TextStyle(
                          color: kMainTextColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.blueGrey[300],
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            searchList(searchSnapshot, createChatRoomAndStartConversation),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
