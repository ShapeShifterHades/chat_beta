import 'package:equatable/equatable.dart';

enum ContactStatus { unknown, mutualFriend, iAddedHeDidNot, heAddedIDidNot }

class ContactModel extends Equatable {
  final int id;
  final String name;
  final String status;

  const ContactModel({
    this.id,
    this.name,
    this.status,
  });

  static const empty = ContactModel(id: 99, name: '', status: '');

  factory ContactModel.fromDatabaseJson(Map<String, dynamic> data) =>
      ContactModel(
        /// Converts JSON object that is coming
        /// from querying the database and converts it into [ContactModel] object
        id: data['id'],
        name: data['name'],
        status: data['status'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        ///Convert ContactModel objects that
        ///is about to be stored into the datbase in a form of JSON

        'id': this.id,
        'name': this.name,
        'status': this.status,
      };
  @override
  List<Object> get props => [id, name, status];
}
