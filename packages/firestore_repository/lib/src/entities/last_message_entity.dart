import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/src/models/models.dart';

class LastMessageEntity extends Equatable {
  final MessageToSend? message;

  const LastMessageEntity(
    this.message,
  );

  Map<String, Object?> toJson() {
    return {
      "lastMessage": message?.text,
      "lastMessageAt": FieldValue.serverTimestamp(),
      "lastMessageFrom": message?.senderId,
      "newMessages": FieldValue.increment(1),
    };
  }

  Map<String, Object?> toJsonWithIncrement() {
    return {
      "lastMessage": message?.text,
      "lastMessageAt": FieldValue.serverTimestamp(),
      "lastMessageFrom": message?.senderId,
    };
  }

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return 'LastMessage entity { message: $message}';
  }

  Map<String, Object?> toDocument() {
    return {
      "lastMessage": message?.text,
      "lastMessageAt": FieldValue.serverTimestamp(),
      "lastMessageFrom": message?.senderId,
    };
  }

  Map<String, Object?> toDocumentWithIncrement() {
    return {
      "lastMessage": message?.text,
      "lastMessageAt": FieldValue.serverTimestamp(),
      "lastMessageFrom": message?.senderId,
      "newMessages": FieldValue.increment(1),
    };
  }
}
