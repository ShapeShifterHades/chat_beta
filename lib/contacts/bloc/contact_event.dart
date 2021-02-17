part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

/// Sends to another user a friend request with a greeting message.
class ContactRequestSent extends ContactEvent {
  final String contactId;
  final String uid;
  final String message;
  ContactRequestSent({this.contactId, this.uid, this.message});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Friend request sent to {contact: $contactId}';
}

/// Adds to friends another user, who already sent you a request with status 'pending'.
class ContactAcceptedRequest extends ContactEvent {
  final String contactId;
  final String uid;
  ContactAcceptedRequest({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact accepted { contact: $contactId }';
}

/// Removes from another users list document with users id, if status of a user not 'blocked' (by firestore security rules).
class ContactRemovedRequest extends ContactEvent {
  final String contactId;
  final String uid;
  ContactRemovedRequest({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact removed { from contact: $contactId }';
}

/// Sets status of user with [contactId] to 'pending' from 'friend' or 'blocked'.
class ContactRejectedRequest extends ContactEvent {
  final String contactId;
  final String uid;
  ContactRejectedRequest({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact rejected { contact: $contactId }';
}

/// Sets status of user with [contactId] to 'blocked' from 'pending', 'friend', 'blocked'.
class ContactBlocked extends ContactEvent {
  final String contactId;
  final String uid;
  ContactBlocked({this.contactId, this.uid});
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact blocked: {contact: $contactId}';
}

// Event, that triggers loading of contact list
class ContactListLoaded extends ContactEvent {
  final String uid;

  ContactListLoaded({this.uid});

  @override
  List<Object> get props => [uid];
}

class ContactsUpdated extends ContactEvent {
  final Contact contact;

  ContactsUpdated(this.contact);

  @override
  List<Object> get props => [contact];

  @override
  String toString() => 'Contact list updated: {contact: $contact}';
}