import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveFromContactsButton extends StatelessWidget {
  final String myId;
  final String username;
  final String userId;
  final String myUsername;

  const RemoveFromContactsButton({
    Key key,
    this.myId,
    this.username,
    this.userId,
    this.myUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference ourContacts = FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .collection('contacts');

    CollectionReference hisContacts = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addedBy');

    Future<void> removeUserFromOurDbInstance() async {
      //First we add found user to our contacts in our profile db in contacts collection
      return await ourContacts
          .doc(userId)
          .delete()
          .then((value) => print('User Deleted from our contactlist'))
          .catchError((error) => print('Error occured: ' + error.toString()));
    }

    Future<void> removeUserFromHisDbInstance() async {
      //First we add found user to our contacts in our profile db in contacts collection
      return await hisContacts
          .doc(myId)
          .delete()
          .then((value) => print('User deleted from his addedby list'))
          .catchError((error) => print('Error occured: ' + error.toString()));
    }

    removeUserFromMyContacts() async {
      await removeUserFromOurDbInstance();
      await removeUserFromHisDbInstance();
    }

    return MaterialButton(
      padding: EdgeInsets.all(6),
      color: Colors.red,
      onPressed: removeUserFromMyContacts,
      child: Text('Delete'),
    );
  }
}
