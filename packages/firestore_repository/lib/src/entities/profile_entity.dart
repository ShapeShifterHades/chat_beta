import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String uid;
  final String username;
  final String bio;

  const ProfileEntity(this.uid, this.username, this.bio);

  Map<String, Object> toJson() {
    return {
      'uid': uid,
      'username': username,
      'bio': bio,
    };
  }

  @override
  List<Object> get props => [uid, username, bio];

  @override
  String toString() {
    return 'ProfileEntity { uid: $uid, username: $username, bio: $bio }';
  }

  static ProfileEntity fromJson(Map<String, Object> json) {
    return ProfileEntity(
      json['uid'] as String,
      json['username'] as String,
      json['bio'] as String,
    );
  }

  static ProfileEntity fromSnapshot(DocumentSnapshot snap) {
    return ProfileEntity(
      snap.data()['uid'],
      snap.data()['username'],
      snap.data()['bio'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'uid': uid,
      'username': username,
      'bio': bio,
    };
  }
}
