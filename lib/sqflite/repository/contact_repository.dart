import '../contact_dao.dart';
import '../model/contact_model.dart';

/// Contact repository instance
/// TODO implement here interfering with Firebase data to get latest contact updates
class ContactRepository {
  final contactDao = ContactDao();

  Future getAllContacts({String query}) => contactDao.getContacts(query: query);
  Future addNewContact(ContactModel contactModel) =>
      contactDao.createContact(contactModel);
  Future updateContact(ContactModel contactModel) =>
      contactDao.updateContact(contactModel);
  Future deleteContactById(int id) => contactDao.deleteContact(id);
  Future deleteAllContacts() => contactDao.deleteAllContacts();
}
