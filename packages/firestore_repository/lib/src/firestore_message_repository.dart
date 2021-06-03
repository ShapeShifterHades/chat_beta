import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:firestore_repository/src/models/models.dart';

class FirestoreMessageRepository {
  // ----------- HELPER VARIABLES AND FUNCTIONS ----------
  final CollectionReference<Map<String, dynamic>> _userCollection =
      FirebaseFirestore.instance.collection('users');

  DocumentReference<Map<String, dynamic>> _getChatroomDocRef(
      String authId, String roomId) {
    return _userCollection.doc(authId).collection('chatrooms').doc(roomId);
  }

  CollectionReference<Map<String, dynamic>> _getMessagesCollection(
      String authId, String roomId) {
    return _userCollection
        .doc(authId)
        .collection('chatrooms')
        .doc(roomId)
        .collection('messages');
  }

  /// Used to help indicate in chat that app was unable to send a message.
  ///
  MessageToSend _messageIsNotSent(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final MessageToSend cached =
        MessageToSend.fromEntity(MessageToSendEntity.fromJson(doc.data()));
    final MessageToSend res = MessageToSend(
        docId: cached.docId,
        isNew: cached.isNew,
        recieverId: cached.recieverId,
        senderId: cached.senderId,
        text: cached.text);
    return res;
  }

  Future<void> _findAndUpdateLastMessageInDialog(
      String authId, String interlocutorId) async {
    final CollectionReference<Map<String, dynamic>> _messagesCol =
        _getMessagesCollection(authId, interlocutorId);
    final DocumentReference<Map<String, dynamic>> _chatroomDoc =
        _getChatroomDocRef(authId, interlocutorId);
    final Query _queryLastMsg =
        _messagesCol.orderBy('timeSent', descending: true).limit(1);
    try {
      final QuerySnapshot<Map<String, dynamic>> _snap =
          await _queryLastMsg.get() as QuerySnapshot<Map<String, dynamic>>;
      MessageToSend _message;
      LastMessage _lastMessage;
      if (_snap.docs.isNotEmpty) {
        _message = MessageToSend.fromEntity(
            MessageToSendEntity.fromJson(_snap.docs.first.data()));
        _lastMessage = LastMessage(_message);
      } else {
        _lastMessage = LastMessage(MessageToSend());
      }
      await _chatroomDoc.set(
          _lastMessage.toEntity().toJson(),
          SetOptions(mergeFields: [
            'lastMessage',
            'lastMessageAt',
            'lastMessageFrom'
          ]));
    } catch (e) {
      rethrow;
    }
  }

  // ------------ STATIC HELPER FUNCTIONS -----------------

  /// Marks message as read and decrements message counter.
  ///
  /// <String>[messageId] is the documentId of message in messages collection of sender.
  /// <String>[senderId] fireauth id of message sender.
  /// <String>[recieverId] fireauth id of message reciever.
  static Future<void> markAsRead(
      String messageId, String senderId, String recieverId) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    /// Reduce by 1 counter at ['newMessages'] field from ['chatrooms'] collection of [recieverId]
    /// in document [senderId].
    ///
    final DocumentReference _chatroomRef = FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chatrooms')
        .doc(senderId);
    _batch.update(_chatroomRef, {'newMessages': FieldValue.increment(-1)});

    /// Notify message [messageId] sender [senderId] that his message has been read.
    ///
    final DocumentReference _messageRef = FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chatrooms')
        .doc(recieverId)
        .collection('messages')
        .doc(messageId);
    _batch.update(_messageRef, {'isNew': false});

    final DocumentReference _messageRef2 = FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chatrooms')
        .doc(senderId)
        .collection('messages')
        .doc(messageId);
    _batch.update(_messageRef2, {'isNew': false});
    return _batch.commit();
  }

  // ------------ MESSAGES CRUD ---------------------------

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
          _getChatroomDocRef(authId, interlocutorId);
      final DocumentReference authIdChatroomCollRef =
          _getChatroomDocRef(interlocutorId, authId);
      // Create docs for message in both users collections
      batch.set(authIdMessagesCollRef,
          message.toEntity().toJson(authIdMessagesCollRef.id));
      batch.set(roomIdMessagesCollRef,
          message.toEntity().toJson(roomIdMessagesCollRef.id));
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

  /// Delete messages with ids, passed in [idList] from [authId] messages
  /// and then updates last message info from chatroom doc.
  ///
  Future<void> deleteSelectedmessages(
      List<String> idList, String authId, String interlocutorId) {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();
    final CollectionReference _messagesCollRef =
        _getMessagesCollection(authId, interlocutorId);

    for (final String docId in idList) {
      _batch.delete(_messagesCollRef.doc(docId));
    }
    _batch.commit();
    return _findAndUpdateLastMessageInDialog(authId, interlocutorId);
  }

  Future<void> deleteAllMessages(String authId, String interlocutorId) {
    final _collRef = _getMessagesCollection(authId, interlocutorId);
    final _docRef = _getChatroomDocRef(authId, interlocutorId);

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

  Stream<List<MessageToSend>> messages(String authId, String roomId) {
    return _getMessagesCollection(authId, roomId)
        .orderBy('timeSent', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        if (doc.metadata.hasPendingWrites) {
          return _messageIsNotSent(doc);
        }

        return MessageToSend.fromEntity(
            MessageToSendEntity.fromJson(doc.data()));
      }).toList();
    });
  }
}
