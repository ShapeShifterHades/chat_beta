import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final contactTABLE = 'contact';
final myprofileTABLE = 'myprofile';

/// [ContactDatabaseProvider] responds for creation of database instance on device and providing it further
class ContactDatabaseProvider {
  static final ContactDatabaseProvider contactDatabaseProvider =
      ContactDatabaseProvider();

  Database _database;

  /// Gets database instance if created or creates it
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  /// Creates database file with given path
  Future<Database> createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // ContactDB.db is a database instance name
    String path = join(documentDirectory.path, "ContactDB.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  // This is optional, and only used for changing database schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  /// Initiates given database with predefined schema
  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $contactTABLE ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "name TEXT,"
        "status TEXT"
        ")");
    await database.execute("CREATE TABLE $myprofileTABLE ("
        "name TEXT PRIMARY KEY"
        ")");
  }
}
