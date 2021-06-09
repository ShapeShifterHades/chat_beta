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

  Future<String> getAvatarLink(String uid) async {
    String result = 'default/avatar-placeholder.png';
    await userCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          result = documentSnapshot.get(FieldPath(const ['avatar'])) as String;
        } on FirebaseException {
          rethrow;
        }
      } else {}
    });
    return result;
  }

  Future<void> setUpAvatar(UserProfile userProfile) async {
    try {
      await userCollection.doc(userProfile.uid).set(
          userProfile.toEntity().toJson(), SetOptions(mergeFields: ['avatar']));
    } on FirebaseException {
      rethrow;
    }
  }

  Future<String?> getUsernameById(String id) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> documentSnapshot =
          await usernameCollection.where("uid", isEqualTo: id).get();
      return documentSnapshot.docs[0].id;
    } on FirebaseException {
      rethrow;
    }
  }
}
