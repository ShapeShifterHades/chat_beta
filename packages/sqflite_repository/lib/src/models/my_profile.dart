import 'package:equatable/equatable.dart';

class MyProfile extends Equatable {
  final String name;
  const MyProfile({this.name});

  static const empty = MyProfile(
    name: '',
  );

  factory MyProfile.fromDatabaseJson(Map<String, dynamic> data) => MyProfile(
        /// Converts JSON object that is coming
        /// from querying the database and converts it into [MyProfile] object
        name: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        ///Convert MyProfile objects that
        ///is about to be stored into the datbase in a form of JSON

        'name': this.name,
      };
  @override
  List<Object> get props => [name];
}
