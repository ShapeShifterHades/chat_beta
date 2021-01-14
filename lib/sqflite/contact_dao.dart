import 'dart:async';

import 'database_contact.dart';
import 'model/contact_model.dart';

/// Contact data from database access object
class ContactDao {
  final dbProvider = ContactDatabaseProvider.contactDatabaseProvider;

  /// Adds new contact record to contactlist
  Future<int> createContact(ContactModel contactModel) async {
    final db = await dbProvider.database;
    var result = db.insert(contactTABLE, contactModel.toDatabaseJson());
    return result;
  }

  /// Gets contacts list from database if query was passed
  Future<List<ContactModel>> getContacts(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(contactTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(contactTABLE, columns: columns);
    }

    List<ContactModel> contacts = result.isNotEmpty
        ? result.map((item) => ContactModel.fromDatabaseJson(item)).toList()
        : [];
    return contacts;
  }

  /// Updates contact record by passed contact instance(?)
  Future<int> updateContact(ContactModel contactModel) async {
    final db = await dbProvider.database;

    var result = await db.update(contactTABLE, contactModel.toDatabaseJson(),
        where: "id = ?", whereArgs: [contactModel.id]);

    return result;
  }

  /// Delets contact record by id
  Future<int> deleteContact(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(contactTABLE, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  /// Delete all contacts from database
  Future<int> deleteAllContacts() async {
    final db = await dbProvider.database;
    var result = await db.delete(contactTABLE);
    return result;
  }
}
