import './dataproviders/dataproviders.dart';
import './models/models.dart';

/// Contact repository instance
/// TODO implement here interfering with Firebase data to get latest contact updates
class ContactRepository {
  final contactProvider = ContactProvier();

  Future getAllContacts({String query}) =>
      contactProvider.getContacts(query: query);
  Future addNewContact(ContactModel contactModel) =>
      contactProvider.createContact(contactModel);
  Future updateContact(ContactModel contactModel) =>
      contactProvider.updateContact(contactModel);
  Future deleteContactById(int id) => contactProvider.deleteContact(id);
  Future deleteAllContacts() => contactProvider.deleteAllContacts();
}
