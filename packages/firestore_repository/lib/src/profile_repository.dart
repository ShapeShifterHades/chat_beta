import 'dart:async';

import 'models/models.dart';

abstract class ProfileRepository {
  Future<void> addNewProfile(Profile profile);

  Future<void> deleteProfile(Profile profile);

  Future<void> updateProfile(Profile update);
}
