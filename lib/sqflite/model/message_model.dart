class MessageModel {
  int id;
  String text;
  bool isMe;

  MessageModel({
    this.id,
    this.isMe,
    this.text,
  });

  factory MessageModel.fromDatabaseJson(Map<String, dynamic> data) =>
      MessageModel(
        /// Converts JSON object that is coming
        /// from querying the database and converts it into [MessageModel] object
        id: data['id'],
        text: data['text'],

        // Since sqlite doesn't have boolean type for true/false
        // we will 0 to denote that it is false and 1 for true
        isMe: data['is_me'] == 0 ? false : true,
      );

  Map<String, dynamic> toDatabaseJson() => {
        ///Converts MessageModel object that
        ///is about to be stored into the datbase in a form of JSON

        "id": this.id,
        "text": this.text,
        "is_me": this.isMe == false ? 0 : 1,
      };
}
