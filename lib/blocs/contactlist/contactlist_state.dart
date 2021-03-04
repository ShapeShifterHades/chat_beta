part of 'contactlist_bloc.dart';

enum ContactsStatus { friendlist, blocklist, pending, loading }

abstract class ContactlistState extends Equatable {
  final List<Contact> contacts;
  ContactlistState({
    this.contacts = const [],
  });
  @override
  List<Object> get props => [contacts];
}

class ContactlistLoading extends ContactlistState {}

class FriendlistState extends ContactlistState {
  final List<Contact> fullContactlist;
  final List<Contact> contacts;
  FriendlistState({
    @required this.fullContactlist,
  })  : assert(fullContactlist != null),
        contacts = fullContactlist
            .where((contact) => contact.status == 'friend')
            .toList();
  @override
  List<Object> get props => [contacts];
}

class PendinglistState extends ContactlistState {
  final List<Contact> fullContactlist;
  final List<Contact> contacts;

  PendinglistState({
    @required this.fullContactlist,
  })  : assert(fullContactlist != null),
        contacts = fullContactlist
            .where((contact) => contact.status == 'pending')
            .toList();
  @override
  List<Object> get props => [contacts];
}

class BlocklistState extends ContactlistState {
  final List<Contact> blocklist;
  final List<Contact> contacts;

  BlocklistState({
    @required this.blocklist,
  })  : assert(blocklist != null),
        contacts =
            blocklist.where((contact) => contact.status == 'blocked').toList();
  @override
  List<Object> get props => [contacts];
}
