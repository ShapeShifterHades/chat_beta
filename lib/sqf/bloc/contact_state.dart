part of 'contact_bloc.dart';

@immutable
abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactLoadInProgress extends ContactState {}

class ContactLoadSuccess extends ContactState {
  final List<ContactModel> contacts;

  const ContactLoadSuccess([this.contacts = const []]);

  @override
  List<Object> get props => [contacts];

  @override
  String toString() => 'ContactLoadSuccess {contacts: $contacts}';
}

class ContactUpdatedSuccess extends ContactState {
  final int id;
  const ContactUpdatedSuccess(this.id);
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ContactUpdated {id: $id}';
}

class ContactLoadFailure extends ContactState {}
