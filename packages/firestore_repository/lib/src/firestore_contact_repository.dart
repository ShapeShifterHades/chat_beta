import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact_repository.dart';
import 'entities/entities.dart';
import 'models/models.dart';

class FirestoreContactRepository implements ContactRepository {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  @override
  Future<void> addNewContact(Contact contact) {
    return contactCollection.add(contact.toEntity().toDocument());
  }

  @override
  Future<void> deleteContact(Contact contact) async {
    return contactCollection.doc(contact.id).delete();
  }

  @override
  Stream<List<Contact>> contacts() {
    return contactCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Contact.fromEntity(ContactEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateContact(Contact update) {
    return contactCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
