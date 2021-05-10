import 'package:firestore_repository/src/entities/last_message_entity.dart';
import 'package:firestore_repository/src/models/models.dart';

class LastMessage {
  final MessageToSend? message;

  LastMessage(
    this.message,
  );

  LastMessageEntity toEntity() {
    return LastMessageEntity(message);
  }
}
