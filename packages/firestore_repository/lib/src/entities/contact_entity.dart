import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String username;
  final String status;
  final String message;
  final Timestamp requestSentAt;

  const ContactEntity(
    this.id,
    this.username,
    this.status,
    this.message,
    this.requestSentAt,
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'username': username,
      'status': status,
      'message': message,
      'requestSentAt': requestSentAt,
    };
  }

  @override
  List<Object> get props => [id, username, status, message, requestSentAt];

  @override
  String toString() {
    return 'ContactEntity { id: $id, username: $username, status: $status, message: $message, requestSentAt: $requestSentAt}';
  }

  static ContactEntity fromJson(Map<String, Object> json) {
    return ContactEntity(
      json['id'] as String,
      json['username'] as String,
      json['status'] as String,
      json['message'] as String,
      json['requestSentAt'] as Timestamp,
    );
  }

  static ContactEntity fromSnapshot(DocumentSnapshot snap) {
    return ContactEntity(
      snap.data()['id'],
      snap.data()['username'],
      snap.data()['status'],
      snap.data()['message'],
      snap.data()['requestSentAt'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'username': username,
      'status': status,
      'message': message,
      'requestSentAt': requestSentAt,
    };
  }
}
