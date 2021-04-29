import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/contact_entity.dart';
import 'package:firestore_repository/src/models/contact.dart';

class FirestoreContactRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final usernamesCollection =
      FirebaseFirestore.instance.collection('usernames');
  final contactsCollectionOf = (uid) => FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('contacts');
  final blocklistCollectionOf = (uid) => FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('blocklist');

  /// Gets [Contact] by its username
  ///
  ///
  Future<Contact?> findIdByUsername(String username, String selfId) async {
    try {
      DocumentSnapshot idDocumentSnapshot =
          await usernamesCollection.doc(username).get();

      if (idDocumentSnapshot.exists) {
        print('Document exists on the database');
        var uid = idDocumentSnapshot.data()!['uid'].toString();
        var status;

        try {
          DocumentSnapshot? contactDocumentSnapshot =
              await contactsCollectionOf(selfId).doc(uid).get();

          if (contactDocumentSnapshot.exists) {
            status = contactDocumentSnapshot.data()!['status'];
          } else {
            status = 'Not in contacts';
          }
        } catch (e) {}
        print('$uid username: $username');
        return Contact(
            id: uid, status: status ?? 'Not in contacts', username: username);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> findUsernameById(String? id) async {
    QuerySnapshot documentSnapshot =
        await usernamesCollection.where("uid", isEqualTo: id).get();
    print(documentSnapshot.docs.isNotEmpty
        ? 'We have a match for $id!'
        : 'No data found for $id');
    return documentSnapshot.docs.isNotEmpty
        ? documentSnapshot.docs[0].id
        : null;
  }

  /// Sends to user [contactId] a friend request with a greeting message.
  ///
  Future<void> sendRequest(
      {String? contactId, String? uid, String? message}) async {
    final batch = FirebaseFirestore.instance.batch();

    var username1 = await findUsernameById(uid);
    var username2 = await findUsernameById(contactId);
    try {
      batch.set(contactsCollectionOf(contactId).doc(uid), {
        "id": uid,
        "requestFrom": uid,
        "requestTo": contactId,
        "username": username1, // Here we need a username getter.
        "status": "pending",
        "message": message,
        "requestSentAt": FieldValue.serverTimestamp()
      });
      batch.set(contactsCollectionOf(uid).doc(contactId), {
        "id": contactId,
        "requestFrom": uid,
        "requestTo": contactId,
        "username": username2, // Here we need a username getter #2.
        "status": "pending",
        "message": message,
        "requestSentAt": FieldValue.serverTimestamp()
      });
      await batch.commit();
    } catch (e) {
      throw (e);
    }
  }

  /// Changes status in documents of both users to 'friends' from 'pending'
  /// if friend request was not initiated by [uid].
  ///
  /// SECURITY RULES:
  /// update if request.auth != null && resource.data.initiatedBy != request.auth.uid &&
  /// resource.data.status == 'pending' && getAfter(resource).data.status == 'friend'
  /// && request.data.initiatedBy == null
  Future<void> acceptRequest({String? contactId, String? uid}) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      batch.set(
          contactsCollectionOf(contactId).doc(uid),
          {
            "status": "friend",
            "friendAcceptedAt": FieldValue.serverTimestamp()
          },
          SetOptions(merge: true));
      batch.set(
          contactsCollectionOf(uid).doc(contactId),
          {
            "status": "friend",
            "friendAcceptedAt": FieldValue.serverTimestamp()
          },
          SetOptions(merge: true));
      batch.commit();
    } catch (e) {
      throw (e);
    }
  }

  /// Removes document [contactId] from contacts collection of user [uid]
  /// and document [uid] in contacts collection of user [contactId]. if
  /// document status != 'blocked' (by firestore security rules). (deprecated)
  ///
  /// SECURITY RULES:
  /// match /users/{uid}/contacts/{contact}
  /// allow delete: if request.auth.uid == contact || request.auth.uid == uid
  Future<void> removeRequest({String? contactId, String? uid}) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      batch.delete(contactsCollectionOf(contactId).doc(uid));
      batch.delete(contactsCollectionOf(uid).doc(contactId));
      await batch.commit();
    } catch (e) {
      throw (e);
    }
  }

  /// Creates new document with id [contactId] in blocklist collection of user [uid].
  ///
  /// Blocked [contactId] must have no permission to send messages, friend requests.
  /// creates blocked document that in security rules checks if there will be no
  /// such [contactId] document in contacts by 'getAfter'.
  /// SECURITY RULES:
  /// match /users/{uid}/blocklist/{contact}
  /// allow create: if request.auth.uid == uid || request.response.data.contactId == contact;
  /// allow delete: if request.auth.uid == uid;
  Future<void> blockContact({String? contactId, String? uid}) async {
    try {
      await removeRequest(contactId: contactId, uid: uid);
    } catch (e) {
      print(e);
    } finally {
      await blocklistCollectionOf(uid).doc(contactId).set(
        {
          "blockedAt": FieldValue.serverTimestamp(),
          "contactId": contactId,
          "username": contactId, // Implement username getter function
        },
      );
    }
  }

  /// Removes [contactId] document in blocklist collection of user [uid]
  ///
  /// SECURITY RULES:
  /// match /users/{uid}/blocklist/{contact}
  /// allow create: if request.auth.uid == uid || request.response.data.contactId == contact;
  /// allow delete: if request.auth.uid == uid;
  Future<void> removeFromBlocklist({String? contactId, String? uid}) async {
    try {
      await blocklistCollectionOf(uid).doc(contactId).delete();
    } catch (e) {
      throw (e);
    }
  }

  /// Gets a stream of snapshots of user [uid] contacts collection.
  Stream<List<Contact>> contacts({String? uid}) {
    return contactsCollectionOf(uid).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Contact.fromEntity(ContactEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
