import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Represents class for Firestore that is used when creating a new user
class NewProfileEntity extends Equatable {
  final String? uid;
  final String? username;

  const NewProfileEntity({this.uid, this.username});

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'username': username,
    };
  }

  @override
  List<Object?> get props => [uid, username];

  @override
  String toString() {
    return 'ProfileEntity { uid: $uid, username: $username }';
  }

  NewProfileEntity.fromJson(Map<String, Object> json)
      : uid = json['uid'] as String?,
        username = json['username'] as String?;

  NewProfileEntity.fromSnapshot(DocumentSnapshot snap)
      : uid = snap.data()!['uid'] as String?,
        username = snap.data()!['username'] as String?;

  Map<String, Object?> toDocument() {
    return {
      'uid': uid,
      'username': username,
    };
  }
}
