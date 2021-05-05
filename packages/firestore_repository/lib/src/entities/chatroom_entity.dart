import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatroomEntity extends Equatable {
  final String? id;
  final String? username;
  final String? lastMessage;
  final String? lastMessageFrom;
  final Timestamp? lastMessageAt;
  final Timestamp? createdAt;

  const ChatroomEntity(
    this.createdAt,
    this.id,
    this.username, [
    this.lastMessage,
    this.lastMessageFrom,
    this.lastMessageAt,
  ]);

  Map<String, Object?> toJson() {
    return {
      "createdAt": createdAt,
      "id": id,
      "username": username,
      "lastMessage": lastMessage,
      "lastMessageFrom": lastMessageFrom,
      "lastMessageAt": lastMessageAt,
    };
  }

  @override
  List<Object?> get props => [
        createdAt,
        id,
        username,
        lastMessage,
        lastMessageFrom,
        lastMessageAt,
      ];

  @override
  String toString() {
    return 'TodoEntity { name: $id, username: $username, last message: $lastMessage, last message from: $lastMessageFrom, last message at: $lastMessageAt, createdAt: $createdAt}';
  }

  static ChatroomEntity fromJson(Map<String, Object> json) {
    return ChatroomEntity(
      json["createdAt"] as Timestamp?,
      json["id"] as String?,
      json["username"] as String?,
      json["lastMessage"] as String?,
      json["lastMessageFrom"] as String?,
      json["lastMessageAt"] as Timestamp?,
    );
  }

  static ChatroomEntity fromSnapshot(DocumentSnapshot snap) {
    return ChatroomEntity(
      snap.data()!["createdAt"],
      snap.data()!["id"],
      snap.data()!["username"],
      snap.data()!["lastMessage"],
      snap.data()!["lastMessageFrom"],
      snap.data()!["lastMessageAt"],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      "createdAt": createdAt,
      "id": id,
      "username": username,
      "lastMessage": lastMessage,
      "lastMessageFrom": lastMessageFrom,
      "lastMessageAt": lastMessageAt,
    };
  }
}
