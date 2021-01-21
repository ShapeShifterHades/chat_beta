import '../database/databases.dart';
import '../models/models.dart';

/// Contact data from database access object
class MyProfileProvider {
  final dbProvider = ContactDatabaseProvider.contactDatabaseProvider;

  /// Adds new MyProfile record to profileTable
  Future<int> createContact(MyProfile myProfile) async {
    final db = await dbProvider.database;
    var result = db.insert(myprofileTABLE, myProfile.toDatabaseJson());
    return result;
  }

  /// Gets MyProfile from database if query was passed
  Future<MyProfile> getMyProfile({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(myprofileTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(contactTABLE, columns: columns);
    }

    MyProfile profile = result.isNotEmpty
        ? result.map((item) => MyProfile.fromDatabaseJson(item))
        : 'No profile stored';
    return profile;
  }

  /// Updates MyProfile record by passed MyProfile instance(?)
  Future<int> updateMyProfile(MyProfile myProfile) async {
    final db = await dbProvider.database;

    var result = await db.update(myprofileTABLE, myProfile.toDatabaseJson(),
        where: "name = ?", whereArgs: [myProfile.name]);

    return result;
  }

  /// Delete MyProfile from database
  Future<int> deleteMyProfile() async {
    final db = await dbProvider.database;
    var result = await db.delete(myprofileTABLE);
    return result;
  }
}
