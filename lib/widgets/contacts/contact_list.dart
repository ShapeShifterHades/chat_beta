import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:void_chat_beta/widgets/contacts/remove_from_contacts_button.dart';

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

class GetMyContactList extends StatelessWidget {
  final String myId;
  final String myUsername;

  const GetMyContactList({Key key, this.myId, this.myUsername})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(myId)
              .collection('contacts')
              .snapshots(),
          builder: (ctx, contactsSnapshot) {
            if (contactsSnapshot.connectionState == ConnectionState.waiting) {
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
                  checkIt() async {
                    var doc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(myId)
                        .collection('addedBy')
                        .doc(listItem[index].documentID)
                        .get();
                    return doc.exists;
                  }

                  return FutureBuilder(
                      future: checkIt(),
                      builder: (ctx, snapShot) {
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

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
                                        subtitle: snapShot.data
                                            ? Text('In contact list')
                                            : Text('Not in contact list'),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: RemoveFromContactsButton(
                                      myId: myId,
                                      myUsername: myUsername,
                                      userId: listItem[index].documentID,
                                      username: listItem[index]['username'],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      padding: EdgeInsets.all(6),
                                      color: Colors.blue,
                                      onPressed: snapShot.data ? () {} : null,
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
    );
  }
}
