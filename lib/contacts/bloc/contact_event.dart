part of 'contact_bloc.dart';

@immutable
abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => [];
}

class FriendListLoaded extends FriendEvent {}

class FriendRequestAccepted extends FriendEvent {
  // final ContactModel contactModel;
  // const ContactAdded(this.contactModel);
  // @override
  // List<Object> get props => [contactModel];
  // @override
  // String toString() => 'Contact added: {contact: $contactModel}';
}

class FriendRequestSent extends FriendEvent {
  // final int id;
  // const ContactDeleted(this.id);
  // @override
  // List<Object> get props => [id];
  // @override
  // String toString() => 'ContactDeleted { id: $id }';
}

class FriendRequestRejected extends FriendEvent {
  // final ContactModel contactModel;
  // const ContactUpdated(this.contactModel);
  // @override
  // List<Object> get props => [contactModel];
  // @override
  // String toString() => 'ContactUpdated { contact: $contactModel }';
}


class FriendRemovedFromList extends FriendEvent {
  // const DeleteAllContacts();
  // @override
  // List<Object> get props => [];
  // @override
  // String toString() => 'AllContactsDeleted';
}
