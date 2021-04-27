import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


/// Represents class for Firestore that is used when creating a new user
class NewProfileEntity extends Equatable {
  final String? uid;
  final String? username;

  const NewProfileEntity(this.uid, this.username);

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

  static NewProfileEntity fromJson(Map<String, Object> json) {
    return NewProfileEntity(
      json['uid'] as String?,
      json['username'] as String?,
    );
  }

  static NewProfileEntity fromSnapshot(DocumentSnapshot snap) {
    return NewProfileEntity(
      snap.data()!['uid'],
      snap.data()!['username'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'uid': uid,
      'username': username,
    };
  }
}
