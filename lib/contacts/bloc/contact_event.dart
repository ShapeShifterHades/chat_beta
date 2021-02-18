part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

/// Sends to another user a friend request with a greeting message.
class SendContactRequest extends ContactEvent {
  final String contactId;
  final String uid;
  final String message;
  SendContactRequest({this.contactId, this.uid, this.message});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Friend request sent to {contact: $contactId}';
}

/// Adds to friends another user, who already sent you a request with status 'pending'.
class AcceptContactRequest extends ContactEvent {
  final String contactId;
  final String uid;
  AcceptContactRequest({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact accepted { contact: $contactId }';
}

/// Removes from another users list document with users id, if status of a user not 'blocked' (by firestore security rules).
class RemoveContactRequest extends ContactEvent {
  final String contactId;
  final String uid;
  RemoveContactRequest({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact removed { from contact: $contactId }';
}

/// Sets status of user with [contactId] to 'pending' from 'friend' or 'blocked'.
class RejectContactRequest extends ContactEvent {
  final String contactId;
  final String uid;
  RejectContactRequest({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact rejected { contact: $contactId }';
}

/// Sets status of user with [contactId] to 'blocked' from 'pending', 'friend', 'blocked'.
class BlockContact extends ContactEvent {
  final String contactId;
  final String uid;
  BlockContact({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact blocked: {contact: $contactId}';
}

// Event, that triggers loading of contact list
class LoadContacts extends ContactEvent {
  final String uid;

  LoadContacts({this.uid});

  @override
  List<Object> get props => [uid];
}

class ContactsUpdated extends ContactEvent {
  final List<Contact> contacts;

  ContactsUpdated(this.contacts);

  @override
  List<Object> get props => [contacts];

  @override
  String toString() => 'Contact list updated: {contact: $contacts}';
}
