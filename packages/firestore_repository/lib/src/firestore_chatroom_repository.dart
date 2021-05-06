import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';
import 'package:firestore_repository/src/models/chatroom.dart';

class FirestoreChatroomRepository {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addChatroom(Chatroom chatroom, String authId) {
    return userCollection
        .doc(authId)
        .collection('chatrooms')
        .add(chatroom.toEntity().toDocument());
  }

  Future<void> deleteChatroom(Chatroom chatroom, String authId) {
    return userCollection
        .doc(authId)
        .collection('chatrooms')
        .doc(chatroom.id)
        .delete();
  }

  Future<void> updateChatroom(Chatroom chatroom, String authId) {
    return userCollection
        .doc(authId)
        .collection('chatrooms')
        .doc(chatroom.id)
        .update(chatroom.toEntity().toJson());
  }

  Stream<List<Chatroom>> chatrooms(String authId) {
    return userCollection
        .doc(authId)
        .collection('chatrooms')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => Chatroom.fromEntity(ChatroomEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
