enum ContactStatus { unknown, mutualFriend, iAddedHeDidNot, heAddedIDidNot }

class ContactModel {
  int id;
  String name;
  ContactStatus status;

  ContactModel({
    this.id,
    this.name,
    this.status = ContactStatus.unknown,
  });

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
}
