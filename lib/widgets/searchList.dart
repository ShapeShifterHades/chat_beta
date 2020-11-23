import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/helper/constants.dart';

Widget searchList(QuerySnapshot searchSnapshot, Function func) {
  return searchSnapshot != null
      ? ListView.builder(
          itemCount: searchSnapshot.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SearchTile(
              userName: searchSnapshot.docs[0].get('name').toString(),
              userEmail: searchSnapshot.docs[0].get('email').toString(),
            );
          })
      : Container();
}

class SearchTile extends StatelessWidget {
  final Function func;
  final String userName;
  final String userEmail;

  SearchTile({this.userEmail, this.userName, this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(color: kMainTextColor)),
              Text(userEmail, style: TextStyle(color: kMainTextColor)),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              func(context, userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: kPrimarySwatchColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                'Message',
                style: TextStyle(color: kMainTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
