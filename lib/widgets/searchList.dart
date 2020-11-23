import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';

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
              print(userName);
              func(userName: userName);
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
