import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Contact {
  final String id;
  final String name;

  Contact({this.id, this.name});

  Contact copyWith({String id, String name}) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  int get hashcode => id.hashCode ^ name.hashCode;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  String toString() {
    return 'Contact{id: $id, name: $name}';
  }

  ContactEntity toEntity() {
    return ContactEntity(id, name);
  }

  static Contact fromEntity(ContactEntity entity) {
    return Contact(
      id: entity.id,
      name: entity.name,
    );
  }
}
