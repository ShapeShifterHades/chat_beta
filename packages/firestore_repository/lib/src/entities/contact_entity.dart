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

  ContactEntity.fromJson(Map<String, Object> json)
      : id = json['id'] as String?,
        username = json['username'] as String?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        requestSentAt = json['requestSentAt'] as Timestamp?,
        requestFrom = json['requestFrom'] as String?;

  ContactEntity.fromSnapshot(DocumentSnapshot snap)
      : id = snap.data()!['id'] as String?,
        username = snap.data()!['username'] as String?,
        status = snap.data()!['status'] as String?,
        message = snap.data()!['message'] as String?,
        requestSentAt = snap.data()!['requestSentAt'] as Timestamp?,
        requestFrom = snap.data()!['requestFrom'] as String?;

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
