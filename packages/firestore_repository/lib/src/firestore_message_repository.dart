import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:firestore_repository/src/models/models.dart';

class FirestoreMessageRepository {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference _getMessagesCollection(String authId, String roomId) {
    return userCollection
        .doc(authId)
        .collection('chatrooms')
        .doc(roomId)
        .collection('messages');
  }

  DocumentReference _getChatroomRef(String authId, String roomId) {
    return userCollection.doc(authId).collection('chatrooms').doc(roomId);
  }

  /// Sends a [message] from user [authId] to user [interlocutorId] and
  /// updates chatrooms last message info.
  ///
  Future<void> addMessage(
      MessageToSend message, String authId, String? interlocutorId) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      // Seting up document references for batch
      final DocumentReference authIdMessagesCollRef =
          _getMessagesCollection(authId, interlocutorId!).doc();
      final DocumentReference roomIdMessagesCollRef =
          _getMessagesCollection(interlocutorId, authId).doc();
      final DocumentReference authIdChatroomCollRef =
          _getChatroomRef(authId, interlocutorId);
      final DocumentReference roomIdChatroomCollRef =
          _getChatroomRef(interlocutorId, authId);
      // Create docs for message in both users collections
      batch.set(authIdMessagesCollRef,
          message.toEntity().toJson(authIdMessagesCollRef.id));
      batch.set(roomIdMessagesCollRef,
          message.toEntity().toJson(roomIdMessagesCollRef.id));
      // Update last message brief for chats, based on sent message
      batch.set(authIdChatroomCollRef, LastMessage(message).toEntity().toJson(),
          SetOptions(merge: true));
      batch.set(roomIdChatroomCollRef, LastMessage(message).toEntity().toJson(),
          SetOptions(merge: true));

      // Atomically commit the changes.
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMessage(
      MessageToSend message, String? authId, String? roomId) {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final DocumentReference doc1 =
        _getMessagesCollection(authId!, roomId!).doc(message.docId);
    final DocumentReference doc2 =
        _getMessagesCollection(authId, roomId).doc(message.docId);
    batch.delete(doc1);
    batch.delete(doc2);
    return batch.commit();
  }

  Future<void> updateMessage(
      MessageToSend message, String? authId, String? roomId) {
    // TODO: Make 'edited' feature on message, (merge: true?)
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final DocumentReference doc1 =
        _getMessagesCollection(authId!, roomId!).doc(message.docId);
    final DocumentReference doc2 =
        _getMessagesCollection(authId, roomId).doc(message.docId);
    batch.update(doc1, message.toEntity().toJson(message.docId!));
    batch.update(doc2, message.toEntity().toJson(message.docId!));
    return batch.commit();
  }

  Stream<List<MessageToSend>> messages(String? authId, String? roomId) {
    return _getMessagesCollection(authId!, roomId!)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) =>
              MessageToSend.fromEntity(MessageToSendEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
