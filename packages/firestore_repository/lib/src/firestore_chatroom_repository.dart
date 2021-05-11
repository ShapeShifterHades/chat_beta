import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';
import 'package:firestore_repository/src/models/chatroom.dart';

class FirestoreChatroomRepository {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference _getChatroomCollection(String authId) {
    return userCollection.doc(authId).collection('chatrooms');
  }

  Future<String> _getUsername(String userId) async {
    final DocumentSnapshot _userSnap;
    try {
      _userSnap = await userCollection.doc(userId).get();
      return _userSnap.data()!["username"] as String;
    } catch (e) {
      rethrow;
    }
  }

  /// Gets a new created [Chatroom] from users 'chatrooms' collection
  /// to start a conversation
  ///
  Future<Chatroom> getChatroom(String authId, String chatId) async {
    try {
      final DocumentSnapshot snap =
          await _getChatroomCollection(authId).doc(chatId).get();
      return Chatroom.fromEntity(ChatroomEntity.fromSnapshot(snap));
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
      final DocumentReference _ourDoc =
          _getChatroomCollection(authId).doc(chatroom.id);
      final DocumentReference _userDoc =
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
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => Chatroom.fromEntity(ChatroomEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
