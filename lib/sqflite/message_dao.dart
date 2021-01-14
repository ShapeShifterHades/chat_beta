import 'dart:async';
import 'database_message.dart';
import 'model/message_model.dart';

class MessageModelDao {
  final dbProvider = MessageDatabaseProvider.messageDbProvider;

  //Adds new messageModel records
  Future<int> createmessageModel(MessageModel messageModel) async {
    final db = await dbProvider.database;
    var result = db.insert(messageTABLE, messageModel.toDatabaseJson());
    return result;
  }

  //Get All messageModel items
  //Searches if query string was passed
  Future<List<MessageModel>> getmessageModels(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(messageTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(messageTABLE, columns: columns);
    }

    List<MessageModel> messageModels = result.isNotEmpty
        ? result.map((item) => MessageModel.fromDatabaseJson(item)).toList()
        : [];
    return messageModels;
  }

  //Update messageModel record
  Future<int> updatemessageModel(MessageModel messageModel) async {
    final db = await dbProvider.database;

    var result = await db.update(messageTABLE, messageModel.toDatabaseJson(),
        where: "id = ?", whereArgs: [messageModel.id]);

    return result;
  }

  //Delete messageModel record
  Future<int> deletemessageModel(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(messageTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //Not implemented yet
  Future<int> deleteAllmessageModels() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      messageTABLE,
    );

    return result;
  }
}
