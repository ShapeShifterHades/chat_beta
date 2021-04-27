import 'dart:async';

import 'models/models.dart';

abstract class ContactRepository {
  Future<void> sendRequest(String contactId, String uid);

  Future<void> deleteContact(Contact contact);

  Stream<List<Contact>> contacts();

  Future<void> updateContact(Contact contact);
}
