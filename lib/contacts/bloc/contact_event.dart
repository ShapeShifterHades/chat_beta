part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class FindUsernameById extends ContactEvent {
  final contactId;

  FindUsernameById(this.contactId);

  @override
  List<Object> get props => [contactId];

  @override
  String toString() => 'Initiating username search query for user: $contactId}';
}

class FindIdByUsername extends ContactEvent {
  final String username;

  FindIdByUsername(this.username);

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'Initiating username search query for user: $username}';
}

/// Sends to users [contactId] contacts collection a friend request with a
/// greeting [message] and status: 'pending'.
///
/// Usage in scope of [ContactBloc] provider:
/// ```
/// context
///   .read<ContactsBloc>()
///   .add(SendContactRequest(contactId: contactId,
///                             uid: context.read<AuthenticationBloc>().state.user.id));
/// ```
/// NOTE: usage of [uid] named parameter is temporary option and will be
/// removed since [ContactBloc] handles passing it to [FirestoreContactRepository].
/// TOIMPLEMENT: Firestore security rules has to check and allow creation
/// of a document only if there is no document with [uid] already.
/// TOIMPLEMENT: Atomically create a document in [uid] contact collection
/// document [contactId] with status 'pending', if there is no doc with such [contactId].
class SendFriendshipRequest extends ContactEvent {
  final String contactId;
  final String uid;
  final String message;
  SendFriendshipRequest({
    @required this.contactId,
    this.uid,
    this.message = '',
  });
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Friend request sent to {contact: $contactId}';
}

/// Changes status of user[contactId] in contacts collection of user [uid]
/// to status: 'friend' from 'pending' or 'blocked'.
///
/// Usage in scope of [ContactBloc] provider:
/// ```
/// context
///   .read<ContactsBloc>()
///   .add(AcceptContactRequest(contactId: contactId,
///                             uid: context.read<AuthenticationBloc>().state.user.id));
/// ```
/// NOTE: usage of [uid] named parameter is temporary option and will be
/// removed since [ContactBloc] handles passing it to [FirestoreContactRepository].
/// TO IMPLEMENT: Must send in response (atomic) creation of document [uid] with
/// status: 'friend' with check if [uid] in his contacts collection has changed
/// [contactId] to status: 'friend'.
class AcceptFriendshipRequest extends ContactEvent {
  final String contactId;
  final String uid;
  AcceptFriendshipRequest({
    @required this.contactId,
    this.uid,
  });
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact accepted { contact: $contactId }';
}

/// Removes from contacts collection of user [contactId] a document with
/// users [uid], if status of a user not 'blocked'
/// (by firestore security rules).
///
/// Usage in scope of [ContactBloc] provider:
/// ```
/// context
///   .read<ContactsBloc>()
///   .add(RemoveContactRequest(contactId: contactId,
///                             uid: context.read<AuthenticationBloc>().state.user.id));
/// ```
/// NOTE: usage of [uid] named parameter is temporary option and will be
/// removed since [ContactBloc] handles passing it to [FirestoreContactRepository].
class RemoveContactRequest extends ContactEvent {
  final String contactId;
  final String uid;
  RemoveContactRequest({
    @required this.contactId,
    this.uid,
  });
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact removed { from contact: $contactId }';
}

/// Sets request status of user [contactId] in contacts collection of user [uid]
/// to status:'rejected' from 'pending', 'friend' or 'blocked'.
///
/// Usage in scope of [ContactBloc] provider:
/// ```
/// context
///   .read<ContactsBloc>()
///   .add(RejectContactRequest(contactId: contactId,
///                             uid: context.read<AuthenticationBloc>().state.user.id));
/// ```
/// NOTE: usage of [uid] named parameter is temporary option and will be
/// removed since [ContactBloc] handles passing it to [FirestoreContactRepository].
class RemoveFromBlocklist extends ContactEvent {
  final String contactId;
  final String uid;
  RemoveFromBlocklist({
    @required this.contactId,
    @required this.uid,
  });
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact rejected { contact: $contactId }';
}

/// Sets status of user with [contactId] in contacts collection of user [uid]
/// to 'blocked' from status: 'rejected', 'pending' or 'friend'.
///
/// Usage in scope of [ContactBloc] provider:
/// ```
/// context
///   .read<ContactsBloc>()
///   .add(BlockContact(contactId: contactId,
///                             uid: context.read<AuthenticationBloc>().state.user.id));
/// ```
/// NOTE: usage of [uid] named parameter is temporary option and will be
/// removed since [ContactBloc] handles passing it to [FirestoreContactRepository].
class AddToBlocklist extends ContactEvent {
  final String contactId;
  final String uid;
  AddToBlocklist({
    @required this.contactId,
    @required this.uid,
  });
  @override
  List<Object> get props => [contactId, uid];
  @override
  String toString() => 'Contact blocked: {contact: $contactId}';
}

// Event, that triggers loading of contact list
class LoadContacts extends ContactEvent {
  final String uid;

  LoadContacts({@required this.uid});

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
