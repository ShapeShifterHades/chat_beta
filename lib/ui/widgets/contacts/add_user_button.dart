import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserButton extends StatelessWidget {
  final String myId;
  final String username;
  final String userId;
  final String myUsername;

  const AddUserButton({
    Key key,
    @required this.username,
    @required this.userId,
    @required this.myId,
    @required this.myUsername,
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

    Future<void> addUserToOurDbInstance() async {
      //First we add found user to our contacts in our profile db in contacts collection
      return await ourContacts
          .doc(userId)
          .set({
            'username': username,
            'addedAt': Timestamp.now(),
          })
          .then((value) => print('User Added'))
          .catchError((error) => print('Error occured: ' + error.toString()));
    }

    Future<void> addUserToHisDbInstance() async {
      //First we add found user to our contacts in our profile db in contacts collection
      return await hisContacts
          .doc(myId)
          .set({
            'username': myUsername,
            'addedAt': Timestamp.now(),
          })
          .then((value) => print('User Added'))
          .catchError((error) => print('Error occured: ' + error.toString()));
    }

    Future<void> addUser() async {
      await addUserToOurDbInstance();
      await addUserToHisDbInstance();
    }

    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      child: Text('Add to contacts'),
      color: Colors.cyanAccent,
      onPressed: addUser,
    );
  }
}
