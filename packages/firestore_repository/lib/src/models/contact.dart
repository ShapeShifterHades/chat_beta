import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Contact {
  final String id;
  final String username;
  final String status;

  Contact({this.id, this.username, this.status});

  Contact copyWith({String id, String username, String status}) {
    return Contact(
      id: id ?? this.id,
      username: username ?? this.username,
      status: status ?? this.status,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  int get hashcode => id.hashCode ^ username.hashCode ^ status.hashCode;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          status == other.status;

  @override
  String toString() {
    return 'Contact{id: $id, username: $username, status: $status}';
  }

  ContactEntity toEntity() {
    return ContactEntity(id, username, status);
  }

  static Contact fromEntity(ContactEntity entity) {
    return Contact(
      id: entity.id,
      username: entity.username,
      status: entity.status,
    );
  }
}
