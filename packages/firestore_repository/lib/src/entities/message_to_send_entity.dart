import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageToSendEntity extends Equatable {
  final String? senderId;
  final String? recieverId;
  final String? text;
  final Timestamp? timeSent;
  final bool isNew;
  final String? docId;

  const MessageToSendEntity({
    this.senderId,
    this.recieverId,
    this.text,
    this.timeSent,
    this.isNew = false,
    this.docId,
  });

  Map<String, Object?> toJson(String doc) {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "text": text,
      "timeSent": FieldValue.serverTimestamp(),
      "isNew": isNew,
      "docId": doc,
    };
  }

  MessageToSendEntity.fromJson(Map<String, Object> json)
      : senderId = json["senderId"] as String?,
        recieverId = json["recieverId"] as String?,
        text = json["text"]! as String,
        timeSent = json["timeSent"] as Timestamp?,
        isNew = json["isNew"]! as bool,
        docId = json["docId"] as String?;

  MessageToSendEntity.fromSnapshot(DocumentSnapshot snap)
      : senderId = snap.data()!["senderId"] as String?,
        recieverId = snap.data()!["recieverId"] as String?,
        text = snap.data()!["text"] as String?,
        timeSent = snap.data()!["timeSent"] as Timestamp?,
        isNew = snap.data()!["isNew"] as bool,
        docId = snap.data()!["docId"] as String?;

  @override
  List<Object?> get props => [
        senderId,
        recieverId,
        text,
        timeSent,
        isNew,
        docId,
      ];

  @override
  String toString() {
    return 'MessageToSend entity { senderId: $senderId, recieverId: $recieverId, messageToSend: $text, timeSent: $timeSent, docId: $docId, isNew: $isNew}';
  }

  // NOTE :/ Do I need It?
  Map<String, Object?> toDocument(String docId) {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "text": text,
      "timeSent": timeSent,
      "isNew": isNew,
      "docId": docId,
    };
  }
}
