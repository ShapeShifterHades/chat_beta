import 'package:firestore_repository/src/entities/message_to_send_entity.dart';

class MessageToSend {
  final String? senderId;
  final String? recieverId;
  final String? text;
  final bool isNew;
  final DateTime? timeSent;
  final String? docId;

  MessageToSend({
    this.senderId,
    this.recieverId,
    this.text,
    this.isNew = false,
    this.docId,
    this.timeSent,
  });

  MessageToSendEntity toEntity() {
    return MessageToSendEntity(
      senderId: senderId,
      recieverId: recieverId,
      isNew: isNew,
      text: text,
    );
  }

  MessageToSend.fromEntity(MessageToSendEntity entity)
      : senderId = entity.senderId,
        recieverId = entity.recieverId,
        text = entity.text,
        timeSent = (entity.timeSent != null)
            ? DateTime.fromMillisecondsSinceEpoch(
                entity.timeSent!.millisecondsSinceEpoch)
            : DateTime.now(),
        isNew = entity.isNew,
        docId = entity.docId;
}
