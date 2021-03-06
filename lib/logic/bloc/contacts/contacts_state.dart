part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;

  const ContactsLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];

  @override
  String toString() => 'ContactsLoaded { contacts: $contacts }';
}

class ContactsNotLoaded extends ContactsState {}
