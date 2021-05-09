import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatroomEntity extends Equatable {
  final String? id;
  final String? username;
  final String? lastMessage;
  final String? lastMessageFrom;
  final Timestamp? lastMessageSentAt;
  final Timestamp? lastMessageRecievedAt;
  final Timestamp? createdAt;

  const ChatroomEntity(
    this.createdAt,
    this.id,
    this.username, [
    this.lastMessage,
    this.lastMessageFrom,
    this.lastMessageSentAt,
    this.lastMessageRecievedAt,
  ]);

  Map<String, Object?> toJson() {
    return {
      "createdAt": createdAt,
      "id": id,
      "username": username,
      "lastMessage": lastMessage,
      "lastMessageFrom": lastMessageFrom,
      "lastMessageSentAt": lastMessageSentAt,
      "lastMessageRecievedAt": lastMessageRecievedAt,
    };
  }

  @override
  List<Object?> get props => [
        createdAt,
        id,
        username,
        lastMessage,
        lastMessageFrom,
        lastMessageSentAt,
        lastMessageRecievedAt,
      ];

  @override
  String toString() {
    return '''
      TodoEntity { name: $id,
      username: $username,
      last message from: $lastMessageFrom,
      last message sent at: $lastMessageSentAt,
      last message recieved at: $lastMessageRecievedAt,
      last message: $lastMessage,
      createdAt: $createdAt}''';
  }

  ChatroomEntity.fromJson(Map<String, Object> json)
      : createdAt = json["createdAt"] as Timestamp?,
        id = json["id"] as String?,
        username = json["username"] as String?,
        lastMessage = json["lastMessage"] as String?,
        lastMessageFrom = json["lastMessageFrom"] as String?,
        lastMessageSentAt = json["lastMessageSentAt"] as Timestamp?,
        lastMessageRecievedAt = json["lastMessageRecievedAt"] as Timestamp?;

  ChatroomEntity.fromSnapshot(DocumentSnapshot snap)
      : createdAt = snap.data()!["createdAt"] as Timestamp?,
        id = snap.data()!["id"] as String?,
        username = snap.data()!["username"] as String?,
        lastMessage = snap.data()!["lastMessage"] as String?,
        lastMessageFrom = snap.data()!["lastMessageFrom"] as String?,
        lastMessageSentAt = snap.data()!["lastMessageSentAt"] as Timestamp?,
        lastMessageRecievedAt =
            snap.data()!["lastMessageRecievedAt"] as Timestamp?;

  Map<String, Object?> toDocument() {
    return {
      "createdAt": createdAt,
      "id": id,
      "username": username,
      "lastMessage": lastMessage,
      "lastMessageFrom": lastMessageFrom,
      "lastMessageSentAt": lastMessageSentAt,
      "lastMessageRecievedAt": lastMessageRecievedAt,
    };
  }
}
