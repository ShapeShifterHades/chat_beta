import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/entities/chatroom_entity.dart';
import 'package:firestore_repository/src/models/chatroom.dart';

class FirestoreChatroomRepository {
  final CollectionReference chatroomCollection =
      FirebaseFirestore.instance.collection('messages');

  Future<void> addChatroom(Chatroom chatroom) {
    return chatroomCollection.add(chatroom.toEntity().toDocument());
  }

  Future<void> deleteChatroom(Chatroom chatroom) {
    return chatroomCollection.doc(chatroom.name).delete();
  }

  Future<void> updateChatroom(Chatroom chatroom) {
    return chatroomCollection
        .doc(chatroom.name)
        .update(chatroom.toEntity().toJson());
  }

  Stream<List<Chatroom>> chatrooms() {
    return chatroomCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((QueryDocumentSnapshot doc) =>
          Chatroom.fromEntity(ChatroomEntity.fromSnapshot(doc)));
    });
  }
}
