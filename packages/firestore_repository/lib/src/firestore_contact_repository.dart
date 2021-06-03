import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/contact_entity.dart';
import 'package:firestore_repository/src/models/contact.dart';

class FirestoreContactRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final usernamesCollection =
      FirebaseFirestore.instance.collection('usernames');
  CollectionReference<Map<String, dynamic>> contactsCollectionOf(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('contacts');
  CollectionReference<Map<String, dynamic>> blocklistCollectionOf(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('blocklist');

  /// Gets [Contact] by its username
  ///
  ///
  Future<Contact?> findIdByUsername(String username, String selfId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> idDocumentSnapshot =
          await usernamesCollection.doc(username).get();

      if (idDocumentSnapshot.exists) {
        final String uid = await FirebaseFirestore.instance
            .runTransaction((transaction) async {
          final _userSnapshot = transaction
              .get(idDocumentSnapshot.reference)
              .then((value) => value.data());
          return (_userSnapshot as Map<String, dynamic>)['uid'] as String;
        });

        String status;

        final DocumentSnapshot<Map<String, dynamic>> contactDocumentSnapshot =
            await contactsCollectionOf(selfId).doc(uid).get();

        if (contactDocumentSnapshot.exists) {
          final Map<String, dynamic>? _data = contactDocumentSnapshot.data();
          if (_data != null) {
            status = _data['status'] as String;
          } else {
            status = 'Not in contacts';
          }
        } else {
          status = 'Not in contacts';
        }

        return Contact(id: uid, status: status, username: username);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<String?> findUsernameById(String? id) async {
    final QuerySnapshot<Map<String, dynamic>> documentSnapshot =
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
    return contactsCollectionOf(uid!)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Contact.fromEntity(ContactEntity.fromJson(doc.data())))
          .toList();
    });
  }
}
