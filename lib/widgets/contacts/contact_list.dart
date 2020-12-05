import 'package:flutter/material.dart';

import 'get_my_contact_list.dart';

class ContactList extends StatelessWidget {
  final String myId;
  final String myUsername;

  const ContactList({
    Key key,
    this.myId,
    this.myUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: GetMyContactList(
              myId: myId,
              myUsername: myUsername,
            ),
          ),
        ],
      ),
    );
  }
}
