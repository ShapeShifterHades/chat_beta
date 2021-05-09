import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/contact_entity.dart';
import 'package:firestore_repository/src/models/contact.dart';

class FirestoreContactRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final usernamesCollection =
      FirebaseFirestore.instance.collection('usernames');
  CollectionReference contactsCollectionOf(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('contacts');
  CollectionReference blocklistCollectionOf(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('blocklist');

  /// Gets [Contact] by its username
  ///
  ///
  Future<Contact?> findIdByUsername(String username, String selfId) async {
    try {
      final DocumentSnapshot idDocumentSnapshot =
          await usernamesCollection.doc(username).get();

      if (idDocumentSnapshot.exists) {
        final String uid = idDocumentSnapshot.data()!['uid'].toString();
        String? status;

        try {
          final DocumentSnapshot contactDocumentSnapshot =
              await contactsCollectionOf(selfId).doc(uid).get();

          if (contactDocumentSnapshot.exists) {
            status = contactDocumentSnapshot.data()!['status'] as String;
          } else {
            status = 'Not in contacts';
          }
        } catch (e) {
          // ignore: avoid_print
          print(e);
        }
        return Contact(
            id: uid, status: status ?? 'Not in contacts', username: username);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<String?> findUsernameById(String? id) async {
    final QuerySnapshot documentSnapshot =
        await usernamesCollection.where("uid", isEqualTo: id).get();

    return documentSnapshot.docs.isNotEmpty
        ? documentSnapshot.docs[0].id
        : null;
  }

  /// Sends to user [contactId] a friend request with a greeting message.
  ///
  Future<void> sendRequest(
      {String? contactId, String? uid, String? message}) async {
    final batch = FirebaseFirestore.instance.batch();

    final String? username1 = await findUsernameById(uid);
    final String? username2 = await findUsernameById(contactId);
    try {
      batch.set(contactsCollectionOf(contactId!).doc(uid), {
        "id": uid,
        "requestFrom": uid,
        "requestTo": contactId,
        "username": username1, // Here we need a username getter.
        "status": "pending",
        "message": message,
        "requestSentAt": FieldValue.serverTimestamp()
      });
      batch.set(contactsCollectionOf(uid!).doc(contactId), {
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
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> acceptRequest({String? contactId, String? uid}) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      batch.set(
          contactsCollectionOf(contactId!).doc(uid),
          {
            "status": "friend",
            "friendAcceptedAt": FieldValue.serverTimestamp()
          },
          SetOptions(merge: true));
      batch.set(
          contactsCollectionOf(uid!).doc(contactId),
          {
            "status": "friend",
            "friendAcceptedAt": FieldValue.serverTimestamp()
          },
          SetOptions(merge: true));
      batch.commit();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> removeRequest({String? contactId, String? uid}) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      batch.delete(contactsCollectionOf(contactId!).doc(uid));
      batch.delete(contactsCollectionOf(uid!).doc(contactId));
      await batch.commit();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> blockContact({String? contactId, String? uid}) async {
    try {
      await removeRequest(contactId: contactId, uid: uid);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      await blocklistCollectionOf(uid!).doc(contactId).set(
        {
          "blockedAt": FieldValue.serverTimestamp(),
          "contactId": contactId,
          "username": contactId, // Implement username getter function
        },
      );
    }
  }

  Future<void> removeFromBlocklist({String? contactId, String? uid}) async {
    try {
      await blocklistCollectionOf(uid!).doc(contactId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  /// Gets a stream of snapshots of user [uid] contacts collection.
  Stream<List<Contact>> contacts({String? uid}) {
    return contactsCollectionOf(uid!).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Contact.fromEntity(ContactEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
