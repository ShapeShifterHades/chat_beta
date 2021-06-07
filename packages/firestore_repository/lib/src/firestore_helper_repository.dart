import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/models/models.dart';

class FirestoreHelperRepository {
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> usernameCollection =
      FirebaseFirestore.instance.collection('usernames');

  Future<bool> isUsernameExists(String username) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await usernameCollection.doc(username).get();
      return doc.exists;
    } catch (e) {
      return true;
    }
  }

  /// Commits a batch of two documents to users collection and Username collection
  /// with a given [userProfile] on user creation
  Future<void> addNewUser(UserProfile userProfile) async {
    try {
      await userCollection
          .doc(userProfile.uid)
          .set({"username": userProfile.username});
      await usernameCollection
          .doc(userProfile.username)
          .set({"uid": userProfile.uid});
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  Future<bool> userHasAvatar(String uid) async {
    await userCollection
        .doc(uid)
        .get(const GetOptions(source: Source.cache))
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document data: ${documentSnapshot.data()}');
        try {
          documentSnapshot.get(FieldPath(const ['avatar']));
          return true;
        } catch (e) {
          // print('No nested field exists!');
          return false;
        }
      } else {
        // print('Document does not exist on the database');
        return false;
      }
    });
    return false;
  }

  Future<void> setUpAvatar(UserProfile userProfile) async {
    try {
      await userCollection.doc(userProfile.uid).set(
          userProfile.toEntity().toJson(), SetOptions(mergeFields: ['avatar']));
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<String?> getUsernameById(String id) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> documentSnapshot =
          await usernameCollection.where("uid", isEqualTo: id).get();
      return documentSnapshot.docs[0].id;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
