import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';

class Chatroom {
  final String? id;
  final String? username;
  final String? lastMessage;
  final String? lastMessageFrom;
  final DateTime? lastMessageSentAt;
  final DateTime? lastMessageRecievedAt;
  final DateTime? createdAt;

  Chatroom({
    DateTime? createdAt,
    this.id,
    this.username,
    this.lastMessage,
    this.lastMessageFrom,
    this.lastMessageSentAt,
    this.lastMessageRecievedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Chatroom toString({})
  //
  ChatroomEntity toEntity() {
    return ChatroomEntity(
      Timestamp.fromDate(createdAt!),
      id,
      username,
      lastMessage,
      lastMessageFrom,
      Timestamp.fromDate(lastMessageSentAt!),
      Timestamp.fromDate(lastMessageRecievedAt!),
    );
  }

  Chatroom.fromEntity(ChatroomEntity entity)
      : createdAt = DateTime?.fromMillisecondsSinceEpoch(
            entity.createdAt!.millisecondsSinceEpoch),
        id = entity.id,
        username = entity.username,
        lastMessage = entity.lastMessage,
        lastMessageFrom = entity.lastMessageFrom,
        lastMessageSentAt = DateTime?.fromMillisecondsSinceEpoch(
            entity.lastMessageSentAt!.millisecondsSinceEpoch),
        lastMessageRecievedAt = DateTime?.fromMillisecondsSinceEpoch(
            entity.lastMessageRecievedAt!.millisecondsSinceEpoch);
}

//  {
//   return Chatroom(
//     createdAt: DateTime?.fromMillisecondsSinceEpoch(
//         entity.createdAt!.millisecondsSinceEpoch),
//     id: entity.id,
//     username: entity.username,
//     lastMessage: entity.lastMessage,
//     lastMessageFrom: entity.lastMessageFrom,
//     lastMessageSentAt: DateTime?.fromMillisecondsSinceEpoch(
//         entity.lastMessageSentAt!.millisecondsSinceEpoch),
//     lastMessageRecievedAt: DateTime?.fromMillisecondsSinceEpoch(
//         entity.lastMessageRecievedAt!.millisecondsSinceEpoch),
//   );
// }
// }
