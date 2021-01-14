import '../repository/contact_repository.dart';
import '../model/contact_model.dart';

import 'dart:async';

class ContactBlocOld {
  final ContactRepository _contactRepository = ContactRepository();
  final _contactController = StreamController<List<ContactModel>>.broadcast();

  get contacts => _contactController.stream;

  ContactBlocOld() {
    getContacts();
  }

  getContacts({String query}) async {
    // Sink is the way of adding data reactively to stream by registering a new event
    _contactController.sink
        .add(await _contactRepository.getAllContacts(query: query));
  }

  addContact(ContactModel contactModel) async {
    await _contactRepository.addNewContact(contactModel);
    getContacts();
  }

  updateContact(ContactModel contactModel) async {
    await _contactRepository.updateContact(contactModel);
    getContacts();
  }

  deleteContactById(int id) async {
    await _contactRepository.deleteContactById(id);
    getContacts();
  }

  dispose() {
    _contactController.close();
  }
}
