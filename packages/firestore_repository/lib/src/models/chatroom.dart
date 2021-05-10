import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';

class Chatroom {
  final String id;
  final String? username;
  final String? lastMessage;
  final String? lastMessageFrom;
  final DateTime? lastMessageAt;
  final bool? isNew;
  final DateTime? createdAt;

  Chatroom({
    DateTime? createdAt,
    required this.id,
    this.username,
    this.lastMessage,
    this.lastMessageFrom,
    this.lastMessageAt,
    this.isNew,
  }) : createdAt = createdAt ?? DateTime.now();

  Chatroom copyWith({
    String? id,
    String? username,
  }) {
    return Chatroom(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  // Chatroom toString({})
  //
  ChatroomEntity toEntity() {
    return ChatroomEntity(
      createdAt: Timestamp.fromDate(createdAt!),
      id: id,
      username: username,
      lastMessage: lastMessage,
      lastMessageFrom: lastMessageFrom,
      lastMessageAt:
          (lastMessageAt != null) ? Timestamp.fromDate(lastMessageAt!) : null,
      isNew: isNew,
    );
  }

  Chatroom.fromEntity(ChatroomEntity entity)
      : createdAt = DateTime?.fromMillisecondsSinceEpoch(
            entity.createdAt!.millisecondsSinceEpoch),
        id = entity.id!,
        username = entity.username,
        lastMessage = entity.lastMessage,
        lastMessageFrom = entity.lastMessageFrom,
        lastMessageAt = (entity.lastMessageAt != null)
            ? DateTime?.fromMillisecondsSinceEpoch(
                entity.lastMessageAt!.millisecondsSinceEpoch)
            : null,
        isNew = entity.isNew;
}
