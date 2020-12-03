import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:void_chat_beta/widgets/contacts/remove_from_contacts_button.dart';

class ContactList extends StatefulWidget {
  final String myId;
  final String myUsername;

  const ContactList({
    Key key,
    this.myId,
    this.myUsername,
  }) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Future<User> getName() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> friendCheck() async {}
    return Expanded(
      child: Container(
        color: Colors.lightGreen,
        child: FutureBuilder(
            future: getName(),
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(futureSnapshot.data.uid)
                      .collection('contacts')
                      .snapshots(),
                  builder: (ctx, contactsSnapshot) {
                    if (contactsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!(contactsSnapshot.data.documents.length > 0)) {
                      return Center(
                        child: Text('No contacts yet'),
                      );
                    }
                    final listItem = contactsSnapshot.data.documents;
                    return ListView.builder(
                        itemCount: listItem.length,
                        itemBuilder: (ctx, index) {
                          // var userCheck = FirebaseFirestore.instance
                          //     .collection('users')
                          //     .doc(widget.myId)
                          //     .collection('addedBy')
                          //     .doc(listItem[index].documentID);
                          // userCheck.get()
                          // // .then((docSnapshot) =>
                          //     {if (docSnapshot.exists) {} else {}});
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Expanded(
                                        flex: 1,
                                        child: ListTile(
                                          key: Key(listItem[index].documentID),
                                          title: Text(
                                            listItem[index]['username'],
                                          ),
                                          subtitle: Text(
                                            DateFormat('kk:mm:ss \n EEE d MMM')
                                                .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        listItem[index]
                                                                    ['addedAt']
                                                                .seconds *
                                                            1000))
                                                .toString(),
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RemoveFromContactsButton(
                                        myId: widget.myId,
                                        myUsername: widget.myUsername,
                                        userId: listItem[index].documentID,
                                        username: listItem[index]['username'],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: MaterialButton(
                                        padding: EdgeInsets.all(6),
                                        color: Colors.blue,
                                        onPressed: () {},
                                        child: Text('Message'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  });
            }),
      ),
    );
  }
}
