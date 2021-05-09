import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Contact {
  final String? id;
  final String? username;
  final String? status;
  final String? message;
  final Timestamp? requestSentAt;
  final String? requestFrom;

  const Contact({
    this.message,
    this.id,
    this.username,
    this.status,
    this.requestSentAt,
    this.requestFrom,
  });

  Contact copyWith({String? id, String? username, String? status}) {
    return Contact(
      id: id ?? this.id,
      username: username ?? this.username,
      status: status ?? this.status,
      message: message ?? message,
      requestSentAt: requestSentAt ?? requestSentAt,
      requestFrom: requestFrom ?? requestFrom,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  int get hashcode =>
      id.hashCode ^
      username.hashCode ^
      status.hashCode ^
      message.hashCode ^
      requestFrom.hashCode;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          status == other.status &&
          message == other.message &&
          requestSentAt == other.requestSentAt &&
          requestFrom == other.requestFrom;

  @override
  String toString() {
    return 'Contact{id: $id, username: $username, status: $status, message: $message, requestSentAt: $requestSentAt, requestFrom: $requestFrom}';
  }

  ContactEntity toEntity() {
    return ContactEntity(
      id,
      username,
      status,
      message,
      requestSentAt,
      requestFrom,
    );
  }

  Contact.fromEntity(ContactEntity entity)
      : id = entity.id,
        username = entity.username,
        status = entity.status,
        message = entity.message,
        requestSentAt = entity.requestSentAt,
        requestFrom = entity.requestFrom;
}
