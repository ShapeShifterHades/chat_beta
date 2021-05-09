import '../entities/entities.dart';

/// Represents a class passed to entity converter
/// added to Firestore when new user creates account
class NewProfile {
  final String? uid;
  final String? username;

  /// Timestamp in milliseconds since epoch shows when account is created
  // final int createdAt;

  NewProfile({this.uid, this.username});

  // User cannot chance his acc uid, username and created at timestamp.
  //
  // Profile copyWith({String uid, String username, int createdAt}) {
  //   return Profile(
  //     uid: uid ?? this.uid,
  //     username: username ?? this.username,
  //     createdAt: createdAt ?? this.createdAt,
  //   );
  // }

  @override
  // ignore: override_on_non_overriding_member
  int get hashcode => uid.hashCode ^ username.hashCode;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewProfile &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          username == other.username;

  @override
  String toString() {
    return 'Profile{uid: $uid, username: $username}';
  }

  NewProfileEntity toEntity() {
    return NewProfileEntity(uid: uid, username: username);
  }

  NewProfile.fromEntity(NewProfileEntity entity)
      : uid = entity.uid,
        username = entity.username;
}
