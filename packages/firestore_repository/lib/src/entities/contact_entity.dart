import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String username;
  final String status;

  const ContactEntity(this.id, this.username, this.status);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'username': username,
      'status': status,
    };
  }

  @override
  List<Object> get props => [id, username, status];

  @override
  String toString() {
    return 'ContactEntity { id: $id, username: $username, status: $status }';
  }

  static ContactEntity fromJson(Map<String, Object> json) {
    return ContactEntity(
      json['id'] as String,
      json['username'] as String,
      json['status'] as String,
    );
  }

  static ContactEntity fromSnapshot(DocumentSnapshot snap) {
    return ContactEntity(
      snap.data()['id'],
      snap.data()['username'],
      snap.data()['status'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'username': username,
      'status': status,
    };
  }
}
