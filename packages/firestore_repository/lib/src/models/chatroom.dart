import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';

class Chatroom {
  final String? name;
  final String? id1;
  final String? id2;
  // final DateTime createdAt;
  final String lastMessage;
  final DateTime? lastMessageAt;
  final String? lastMessageFrom;

  Chatroom({
    this.name = '',
    this.id1,
    this.id2,
    String? lastMessage,
    this.lastMessageFrom,
    this.lastMessageAt,
    // DateTime? createdAt,
  }) :
        // this.createdAt = DateTime.now(),
        this.lastMessage = lastMessage ?? 'none';

  // Chatroom toString({})
  //
  ChatroomEntity toEntity() {
    return ChatroomEntity(
      name,
      id1,
      id2,
      lastMessage,
      lastMessageFrom,
      Timestamp.fromDate(lastMessageAt!),
      // Timestamp.fromDate(createdAt),
    );
  }

  static Chatroom fromEntity(ChatroomEntity entity) {
    return Chatroom(
      name: entity.name,
      id1: entity.id1,
      id2: entity.id2,
      lastMessage: entity.lastMessage,
      lastMessageFrom: entity.lastMessageFrom,
      lastMessageAt: DateTime?.fromMillisecondsSinceEpoch(
          entity.lastMessageAt!.millisecondsSinceEpoch),
      // createdAt: DateTime?.fromMillisecondsSinceEpoch(
      //     entity.createdAt!.millisecondsSinceEpoch),
    );
  }
}
