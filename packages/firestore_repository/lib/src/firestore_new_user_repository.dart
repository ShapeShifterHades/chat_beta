import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/models/models.dart';
import 'profile_repository.dart';

class FirestoreNewUserRepository implements ProfileRepository {
  final newProfileCollection = FirebaseFirestore.instance.collection('profile');

  @override
  Future<void> addNewProfile(Profile profile) {
    return newProfileCollection
        .doc(profile.uid)
        .set(profile.toEntity().toDocument());
  }

  @override
  Future<void> deleteProfile(Profile profile) async {
    return newProfileCollection.doc(profile.uid).delete();
  }

  @override
  Future<void> updateProfile(Profile update) {
    return newProfileCollection
        .doc(update.uid)
        .update(update.toEntity().toDocument());
  }
}
