import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? id;
  final String? username;
  final String? status;
  final String? message;
  final Timestamp? requestSentAt;
  final String? requestFrom;

  const ContactEntity(
    this.id,
    this.username,
    this.status,
    this.message,
    this.requestSentAt,
    this.requestFrom,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'status': status,
      'message': message,
      'requestSentAt': requestSentAt,
      'requestFrom': requestFrom,
    };
  }

  @override
  List<Object?> get props =>
      [id, username, status, message, requestSentAt, requestFrom];

  @override
  String toString() {
    return 'ContactEntity { id: $id, username: $username, status: $status, message: $message, requestSentAt: $requestSentAt, requestFrom: $requestFrom}';
  }

  static ContactEntity fromJson(Map<String, Object> json) {
    return ContactEntity(
      json['id'] as String?,
      json['username'] as String?,
      json['status'] as String?,
      json['message'] as String?,
      json['requestSentAt'] as Timestamp?,
      json['requestFrom'] as String?,
    );
  }

  static ContactEntity fromSnapshot(DocumentSnapshot snap) {
    return ContactEntity(
      snap.data()!['id'],
      snap.data()!['username'],
      snap.data()!['status'],
      snap.data()!['message'],
      snap.data()!['requestSentAt'],
      snap.data()!['requestFrom'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'username': username,
      'status': status,
      'message': message,
      'requestSentAt': requestSentAt,
      'requestFrom': requestFrom,
    };
  }
}
