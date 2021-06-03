import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? senderId;
  final String? recieverId;
  final String? message;
  final Timestamp? timeSent;
  final Timestamp? timeRecieved;
  final String? docId;

  const MessageEntity(
    this.senderId,
    this.recieverId,
    this.message, [
    this.timeSent,
    this.timeRecieved,
    this.docId,
  ]);

  Map<String, Object?> toJson() {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "message": message,
      "timeSent": (timeSent != null) ? FieldValue.serverTimestamp() : null,
      "timeRecieved":
          (timeRecieved != null) ? FieldValue.serverTimestamp() : null,
      "docId": docId,
    };
  }

  @override
  List<Object?> get props => [
        senderId,
        recieverId,
        message,
        timeSent,
        timeRecieved,
        docId,
      ];

  @override
  String toString() {
    return 'Message entity { senderId: $senderId, recieverId: $recieverId, message: $message, timeSent: $timeSent, timeRecieved: $timeRecieved, docId: $docId}';
  }

  MessageEntity.fromJson(Map<String, Object> json)
      : senderId = json["senderId"] as String?,
        recieverId = json["recieverId"] as String?,
        message = json["message"] as String?,
        timeSent = json["timeSent"] as Timestamp?,
        timeRecieved = json["timeRecieved"] as Timestamp?,
        docId = json["docId"] as String?;

  // MessageEntity.fromSnapshot(DocumentSnapshot snap)
  //     : senderId = snap.data()!["senderId"] as String?,
  //       recieverId = snap.data()!["recieverId"] as String?,
  //       message = snap.data()!["message"] as String?,
  //       timeSent = snap.data()!["timeSent"] as Timestamp?,
  //       timeRecieved = snap.data()!["timeRecieved"] as Timestamp?,
  //       docId = snap.data()!["docId"] as String?;

  Map<String, Object?> toDocument(String docId) {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "imessaged": message,
      "timeSent": timeSent,
      "timeRecieved": timeRecieved,
      "docId": docId,
    };
  }
}
