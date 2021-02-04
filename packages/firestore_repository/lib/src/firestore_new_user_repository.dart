import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/models/models.dart';
import 'profile_repository.dart';

class FirestoreNewUserRepository implements NewUserRepository {
  final newUserCollection = FirebaseFirestore.instance.collection('users');
  final newUsernameCollection = FirebaseFirestore.instance.collection('usernames');

  @override
  /// Commits a batch of two documents to users collection and Username collection
  /// with a given [newProfile] on user creation
  Future<void> addNewUser(NewProfile newProfile) {

    return newUsernameCollection.doc(newProfile.uid).set({"username": newProfile.username})
    ;
  }
  // @override
  // Future<void> addNewProfile(NewProfile profile) {
    
  //   return newUserCollection
  //       .doc(profile.uid)
  //       .set(profile.toEntity().toDocument());
  // }

  // @override
  // Future<void> deleteProfile(NewProfile profile) async {
  //   return newUserCollection.doc(profile.uid).delete();
  // }

  // @override
  // Future<void> updateProfile(NewProfile update) {
  //   return newUserCollection
  //       .doc(update.uid)
  //       .update(update.toEntity().toDocument());
  // }
}
