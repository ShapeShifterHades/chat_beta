import 'dart:async';

import 'models/models.dart';

abstract class NewUserRepository {
  // Adds batch of documents to Firebase when user created
  Future<void> addNewUser(NewProfile newProfile);

  // Future<void> addNewProfile(NewProfile newProfile);

  // Future<void> deleteProfile(NewProfile newProfile);

  // Future<void> updateProfile(NewProfile update);
}
