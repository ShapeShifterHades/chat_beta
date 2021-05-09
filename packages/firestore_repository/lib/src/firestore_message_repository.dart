import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/message_entity.dart';
import 'package:firestore_repository/src/models/message.dart';
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

  Future<void> addMessage(
      Message message, String authId, String? roomId) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      // TODO: create batched write of a last message to chatrooms...
      final DocumentReference ref1 =
          _getMessagesCollection(authId, roomId!).doc();
      // final DocumentReference ref2 =
      //     _getMessagesCollection(roomId, authId).doc();
      final DocumentReference ref3 = _getChatroomRef(authId, roomId);
      // final DocumentReference ref4 = _getChatroomRef(roomId, authId);
      batch.set(ref1, message.toEntity().toDocument(ref1.id));
      // batch.set(ref2, message.toEntity().toDocument(ref2.id));
      batch.set(ref3, LastMessage(message: message).toEntity().toDocument(),
          SetOptions(merge: true));
      // batch.set(ref4, LastMessage(message: message).toEntity().toDocument(),
      //     SetOptions(merge: true));

      await batch.commit();
    } catch (e) {
      // ignore: avoid_print
      print('Trying to batch addMessage was error: $e');
    }
    return;
  }

  Future<void> deleteMessage(Message message, String? authId, String? roomId) {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final DocumentReference doc1 =
        _getMessagesCollection(authId!, roomId!).doc(message.docId);
    final DocumentReference doc2 =
        _getMessagesCollection(authId, roomId).doc(message.docId);
    batch.delete(doc1);
    batch.delete(doc2);
    return batch.commit();
  }

  Future<void> updateMessage(Message message, String? authId, String? roomId) {
    // TODO: Make 'edited' feature on message, (merge: true?)
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final DocumentReference doc1 =
        _getMessagesCollection(authId!, roomId!).doc(message.docId);
    final DocumentReference doc2 =
        _getMessagesCollection(authId, roomId).doc(message.docId);
    batch.update(doc1, message.toEntity().toJson());
    batch.update(doc2, message.toEntity().toJson());
    return batch.commit();
  }

  Stream<List<Message>> messages(String? authId, String? roomId) {
    return _getMessagesCollection(authId!, roomId!)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromEntity(MessageEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
