import '../entities/entities.dart';

/// Represents a class passed to entity converter
/// added to Firestore when new user creates account
class UserProfile {
  final String uid;
  final String? username;
  final String? avatar;

  UserProfile({required this.uid, this.username, this.avatar});

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
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          username == other.username &&
          avatar == other.avatar;

  @override
  String toString() {
    return 'Profile{uid: $uid, username: $username}';
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(uid: uid, username: username, avatar: avatar);
  }

  UserProfile.fromEntity(UserProfileEntity entity)
      : uid = entity.uid,
        avatar = entity.avatar,
        username = entity.username;
}
