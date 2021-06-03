import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';
import 'package:firestore_repository/src/models/chatroom.dart';

class FirestoreChatroomRepository {
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference<Map<String, dynamic>> _getChatroomCollection(
      String authId) {
    return userCollection.doc(authId).collection('chatrooms');
  }

  Future<String> _getUsername(String userId) async {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final _userSnapshot = transaction
          .get(userCollection.doc(userId))
          .then((value) => value.data());
      return (_userSnapshot as Map<String, dynamic>)['username'] as String;
    });
  }

  /// Gets a new created [Chatroom] from users 'chatrooms' collection
  /// to start a conversation
  ///
  Future<Chatroom> getChatroom(String authId, String chatId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snap =
          await _getChatroomCollection(authId).doc(chatId).get();

      return Chatroom.fromEntity(ChatroomEntity.fromJson(snap.data()!));
    } catch (e) {
      rethrow;
    }
  }

  /// Creates initial data for chatroom inside of the both chatroom collections
  /// when user [authId] want to set up a conversation with user [chatroom.id]
  ///
  Future<void> addChatroom(Chatroom chatroom, String authId) async {
    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      // First we get usernames for chatrooms initialization info
      final _ourUsername = await _getUsername(authId);
      final _userUsername = await _getUsername(chatroom.id);
      // Set up DocumentReference to our and other user chatroom collections
      final DocumentReference<Map<String, dynamic>> _ourDoc =
          _getChatroomCollection(authId).doc(chatroom.id);
      final DocumentReference<Map<String, dynamic>> _userDoc =
          _getChatroomCollection(chatroom.id).doc(authId);
      // Set up chatroom data for both sides
      final Map<String, Object?> _chatroom =
          chatroom.copyWith(username: _userUsername).toEntity().toJson();
      final Map<String, Object?> _chatroomMirror = chatroom
          .copyWith(id: authId, username: _ourUsername)
          .toEntity()
          .toJson();

      // Create documents with our data
      batch.set(
          _ourDoc, _chatroom, SetOptions(mergeFields: ['id', 'username']));
      batch.set(_userDoc, _chatroomMirror,
          SetOptions(mergeFields: ['id', 'username']));

      // Atomically commit changes
      batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteChatroom(Chatroom chatroom, String authId) {
    return _getChatroomCollection(authId).doc(chatroom.id).delete();
  }

  Future<void> updateChatroom(Chatroom chatroom, String authId) {
    return _getChatroomCollection(authId)
        .doc(chatroom.id)
        .update(chatroom.toEntity().toJson());
  }

  Stream<List<Chatroom>> chatrooms(String authId) {
    return _getChatroomCollection(authId)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map(
              (doc) => Chatroom.fromEntity(ChatroomEntity.fromJson(doc.data())))
          .toList();
    });
  }
}
