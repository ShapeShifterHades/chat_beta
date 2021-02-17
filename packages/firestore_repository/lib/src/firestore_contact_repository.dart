import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreContactRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  /// Sends to another user a friend request with a greeting message.
  Future<void> sendRequest(
      {String contactId, String uid, String message}) async {
    try {
      await usersCollection.doc(contactId).collection('contacts').doc(uid).set({
        "status": "pending",
        "message": message,
        "requestSentAt": FieldValue.serverTimestamp()
      });
    } catch (e) {
      throw (e);
    }
  }

  /// Adds to friends another user, who already sent you a request with status 'pending'.
  Future<void> acceptRequest({String contactId, String uid}) async {
    try {
      await usersCollection.doc(uid).collection('contacts').doc(contactId).set(
          {"status": "friend", "friendAddedAt": FieldValue.serverTimestamp()});
    } catch (e) {
      throw (e);
    }
  }

  /// Removes from another users list document with users id, if status of a user not 'blocked' (by firestore security rules).
  Future<void> removeRequest({String contactId, String uid}) async {
    try {
      await usersCollection
          .doc(contactId)
          .collection('contacts')
          .doc(uid)
          .delete();
    } catch (e) {
      throw (e);
    }
  }

  /// Sets status of user with [contactId] to 'pending' from 'friend' or 'blocked'.
  Future<void> rejectContact({String contactId, String uid}) async {
    try {
      await usersCollection.doc(uid).collection('contacts').doc(contactId).set(
          {"status": "pending", "rejectedAt": FieldValue.serverTimestamp()});
    } catch (e) {
      throw (e);
    }
  }

  /// Sets status of user with [contactId] to 'blocked' from 'pending', 'friend', 'blocked'.
  Future<void> blockContact({String contactId, String uid}) async {
    try {
      await usersCollection.doc(uid).collection('contacts').doc(contactId).set(
          {"status": "blocked", "blockedAt": FieldValue.serverTimestamp()});
    } catch (e) {
      throw (e);
    }
  }

  /// Gets a stream of snapshots of users contact list.
  Stream<List<dynamic>> contacts({String uid}) {
    return usersCollection
        .doc(uid)
        .collection('contacts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          // .map((doc) => Contact.fromEntity(ContactEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
