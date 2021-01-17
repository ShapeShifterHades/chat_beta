import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String name;

  const ContactEntity(this.id, this.name);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object> get props => [id, name];

  @override
  String toString() {
    return 'ContactEntity { id: $id, name: $name }';
  }

  static ContactEntity fromJson(Map<String, Object> json) {
    return ContactEntity(
      json['id'] as String,
      json['name'] as String,
    );
  }

  static ContactEntity fromSnapshot(DocumentSnapshot snap) {
    return ContactEntity(
      snap.data()['id'],
      snap.data()['name'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
    };
  }
}
