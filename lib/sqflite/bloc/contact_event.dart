part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactLoaded extends ContactEvent {}

class ContactAdded extends ContactEvent {
  final ContactModel contactModel;
  const ContactAdded(this.contactModel);
  @override
  List<Object> get props => [contactModel];
  @override
  String toString() => 'Contact added: {contact: $contactModel}';
}

class ContactUpdated extends ContactEvent {
  final ContactModel contactModel;
  const ContactUpdated(this.contactModel);
  @override
  List<Object> get props => [contactModel];
  @override
  String toString() => 'ContactUpdated { contact: $contactModel }';
}

class ContactDeleted extends ContactEvent {
  final int id;
  const ContactDeleted(this.id);
  @override
  List<Object> get props => [id];
  @override
  String toString() => 'ContactDeleted { id: $id }';
}

class DeleteAllContacts extends ContactEvent {
  const DeleteAllContacts();
  @override
  List<Object> get props => [];
  @override
  String toString() => 'AllContactsDeleted';
}
