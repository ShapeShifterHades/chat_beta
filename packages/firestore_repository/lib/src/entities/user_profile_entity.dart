import 'package:equatable/equatable.dart';

/// Represents class for Firestore that is used when creating a new user
class UserProfileEntity extends Equatable {
  final String uid;
  final String? username;
  final String? avatar;

  const UserProfileEntity({
    required this.uid,
    this.username,
    this.avatar,
  });

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'username': username,
      'avatar': avatar,
    };
  }

  UserProfileEntity.fromJson(Map<String, Object> json)
      : uid = json['uid']! as String,
        username = json['username'] as String?,
        avatar = json['avatar'] as String?;

  @override
  List<Object?> get props => [uid, username, avatar];

  @override
  String toString() {
    return 'ProfileEntity { uid: $uid, username: $username, avatar: $avatar}';
  }
}
