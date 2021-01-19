import '../entities/entities.dart';

class Profile {
  final String uid;
  final String username;
  final String bio;

  Profile({this.uid, this.username, this.bio});

  Profile copyWith({String uid, String username, String bio}) {
    return Profile(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      bio: bio ?? this.bio,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  int get hashcode => uid.hashCode ^ username.hashCode ^ bio.hashCode;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          bio == other.bio &&
          username == other.username;

  @override
  String toString() {
    return 'Profile{uid: $uid, username: $username, bio: $bio}';
  }

  ProfileEntity toEntity() {
    return ProfileEntity(uid, username, bio);
  }

  static Profile fromEntity(ProfileEntity entity) {
    return Profile(
      uid: entity.uid,
      username: entity.username,
      bio: entity.bio,
    );
  }
}
