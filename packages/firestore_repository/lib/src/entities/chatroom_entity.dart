import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatroomEntity extends Equatable {
  final String? id;
  final String? username;
  final String? lastMessage;
  final String? lastMessageFrom;
  final Timestamp? lastMessageAt;
  final int? newMessages;
  final Timestamp? createdAt;

  const ChatroomEntity({
    this.createdAt,
    this.id,
    this.username,
    this.lastMessage,
    this.lastMessageFrom,
    this.lastMessageAt,
    this.newMessages,
  });

  Map<String, Object?> toJson() {
    return {
      "createdAt": createdAt,
      "id": id,
      "username": username,
      "lastMessage": lastMessage,
      "lastMessageFrom": lastMessageFrom,
      "lastMessageSendAt": lastMessageAt,
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
        newMessages,
      ];

  @override
  String toString() {
    return '''
      TodoEntity { name: $id,
      username: $username,
      last message from: $lastMessageFrom,
      last message sent at: $lastMessageAt,
      newMessages: $newMessages,
      last message: $lastMessage,
      createdAt: $createdAt}''';
  }

  ChatroomEntity.fromJson(Map<String, Object> json)
      : createdAt = json["createdAt"] as Timestamp?,
        id = json["id"] as String?,
        username = json["username"] as String?,
        lastMessage = json["lastMessage"] as String?,
        lastMessageFrom = json["lastMessageFrom"] as String?,
        lastMessageAt = json["lastMessageAt"] as Timestamp?,
        newMessages = json["newMessages"] as int?;

  ChatroomEntity.fromSnapshot(DocumentSnapshot snap)
      : createdAt = snap.data()!["createdAt"] as Timestamp?,
        id = snap.data()!["id"] as String?,
        username = snap.data()!["username"] as String?,
        lastMessage = snap.data()!["lastMessage"] as String?,
        lastMessageFrom = snap.data()!["lastMessageFrom"] as String?,
        lastMessageAt = snap.data()!["lastMessageAt"] as Timestamp?,
        newMessages = snap.data()!["newMessages"] as int?;

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
