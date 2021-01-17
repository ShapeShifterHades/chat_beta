import 'dart:async';

import 'models/models.dart';

abstract class ContactRepository {
  Future<void> addNewContact(Contact contact);

  Future<void> deleteContact(Contact contact);

  Stream<List<Contact>> contacts();

  Future<void> updateContact(Contact contact);
}
