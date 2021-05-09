import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/src/models/models.dart';

class LastMessageEntity extends Equatable {
  final Message? message;

  const LastMessageEntity(
    this.message,
  );

  Map<String, Object?> toJson() {
    return {
      "lastMessage": message?.message,
      "lastMessageSentAt": message?.timeSent,
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
      "lastMessage": message?.message,
      // NOTE: Will refactor this anyway
      // ignore: cast_nullable_to_non_nullable
      "lastMessageSentAt": Timestamp?.fromDate(message?.timeSent as DateTime),
      "lastMessageFrom": message?.senderId,
    };
  }
}
