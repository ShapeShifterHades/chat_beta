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
      MessageToSend message, String authId, String interlocutorId) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      // Seting up document references for batch
      final DocumentReference authIdMessagesCollRef =
          _getMessagesCollection(authId, interlocutorId).doc();
      final DocumentReference roomIdMessagesCollRef =
          _getMessagesCollection(interlocutorId, authId)
              .doc(authIdMessagesCollRef.id);
      final DocumentReference roomIdChatroomCollRef =
          _getChatroomRef(authId, interlocutorId);
      final DocumentReference authIdChatroomCollRef =
          _getChatroomRef(interlocutorId, authId);
      // Create docs for message in both users collections
      batch.set(authIdMessagesCollRef,
          message.toEntity().toJson(authIdMessagesCollRef.id));
      batch.set(roomIdMessagesCollRef,
          message.toEntity().toJson(roomIdMessagesCollRef.id));
      // batch.set(roomIdMessagesCollRef,
      // message.toEntity().toJson(roomIdMessagesCollRef.id));
      // Update last message brief for chats, based on sent message
      batch.set(authIdChatroomCollRef, LastMessage(message).toEntity().toJson(),
          SetOptions(merge: true));
      batch.set(
          roomIdChatroomCollRef,
          LastMessage(message).toEntity().toJsonWithIncrement(),
          SetOptions(merge: true));

      // Atomically commit the changes.
      batch.commit();
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

  Future<void> deleteAllMessages(String authId, String interlocutorId) {
    final _collRef = _getMessagesCollection(authId, interlocutorId);
    final _docRef = _getChatroomRef(authId, interlocutorId);

    _collRef.get().then((snapshot) {
      for (final DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    return _docRef.update({
      "lastMessage": '',
      "lastMessageAt": null,
      "newMessages": 0,
      "lastMessageFrom": null,
    });
  }

  Future<void> updateMessage(
      MessageToSend message, String? authId, String? roomId) {
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
        .orderBy('timeSent', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        // if (doc.metadata.hasPendingWrites) {
        //   return _messageIsNotSent(doc);
        // }
        if (doc.data()['isNew'] == true && doc.data()['senderId'] != authId) {
          _markDocumentAsRead(doc, authId, roomId);
          // do i need to return new copy with isNew? false?
          print('FIRE!!!!');
        }
        doc.data()['isNew'] = false;
        return MessageToSend.fromEntity(MessageToSendEntity.fromSnapshot(doc));
      }).toList();
    });
  }

  MessageToSend _messageIsNotSent(QueryDocumentSnapshot doc) {
    final MessageToSend cached =
        MessageToSend.fromEntity(MessageToSendEntity.fromSnapshot(doc));
    final MessageToSend res = MessageToSend(
        docId: cached.docId,
        isNew: cached.isNew,
        recieverId: cached.recieverId,
        senderId: cached.senderId,
        text: cached.text);
    return res;
  }

  /// Marks message [doc] isNew field as false and decrements new message counter'
  /// by 1
  ///
  Future<void> _markDocumentAsRead(
      QueryDocumentSnapshot doc, String? authId, String? roomId) {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    // Mark document as opened in our message collection.
    batch.update(doc.reference, {'isNew': false});

    // Here we decrement new message counter in chatroom info.
    final DocumentReference chatDocRef =
        userCollection.doc(authId).collection('chatrooms').doc(roomId);
    batch.update(chatDocRef, {'newMessages': FieldValue.increment(-1)});
    // Here we notify interlocutor that his message was opened.
    final DocumentReference messageDocRef = userCollection
        .doc(roomId)
        .collection('chatrooms')
        .doc(authId)
        .collection('messages')
        .doc(doc.id);
    batch.update(messageDocRef, {'isNew': false});

    return batch.commit();
  }
}
