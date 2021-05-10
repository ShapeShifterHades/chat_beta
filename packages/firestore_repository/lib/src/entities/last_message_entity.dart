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
      "lastMessageAt": message?.timeSent,
      "lastMessageFrom": message?.senderId,
      "isNew": message?.isNew,
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
      "isNew": message?.isNew,
    };
  }
}
