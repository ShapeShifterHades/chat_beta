import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/models/models.dart';
import 'profile_repository.dart';

class FirestoreNewUserRepository implements NewUserRepository {
  final newUserCollection = FirebaseFirestore.instance.collection('users');
  final newUsernameCollection =
      FirebaseFirestore.instance.collection('usernames');

  Future<bool> usernameAlreadyExists(String username) async {
    try {
      final DocumentSnapshot doc =
          await newUsernameCollection.doc(username).get();
      return doc.exists;
    } catch (e) {
      return true;
    }
  }

  /// Commits a batch of two documents to users collection and Username collection
  /// with a given [newProfile] on user creation
  @override
  Future<void> addNewUser(NewProfile newProfile) async {
    try {
      await newUserCollection
          .doc(newProfile.uid)
          .set({"username": newProfile.username});
      await newUsernameCollection
          .doc(newProfile.username)
          .set({"uid": newProfile.uid});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
