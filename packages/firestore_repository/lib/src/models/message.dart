import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/message_entity.dart';

class Message {
  final String? senderId;
  final String? recieverId;
  final String? message;
  final DateTime? timeSent;
  final DateTime? timeRecieved;
  final String? docId;

  Message({
    this.senderId,
    this.recieverId,
    this.message,
    DateTime? timeSent,
    this.timeRecieved,
    this.docId,
  }) : timeSent = timeSent ?? DateTime.now();

  // Message toString({})
  //
  MessageEntity toEntity() {
    return MessageEntity(
      senderId,
      recieverId,
      message,
      (timeSent != null)
          ? Timestamp.fromDate(timeSent ?? DateTime.now())
          : null,
      (timeRecieved != null) ? Timestamp.fromDate(DateTime.now()) : null,
      docId,
    );
  }

  Message.fromEntity(MessageEntity entity)
      : senderId = entity.senderId,
        recieverId = entity.recieverId,
        message = entity.message,
        timeSent = DateTime?.fromMillisecondsSinceEpoch(
            entity.timeSent!.millisecondsSinceEpoch),
        timeRecieved = DateTime?.fromMillisecondsSinceEpoch(
            entity.timeRecieved!.millisecondsSinceEpoch),
        docId = entity.docId;
}
