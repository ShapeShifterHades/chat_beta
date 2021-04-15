part of 'contact_tabs_bloc.dart';

enum ContactsStatus { friendlist, blocklist, pending, loading }

abstract class ContactTabsState extends Equatable {
  final List<Contact> contacts;
  ContactTabsState({
    this.contacts = const [],
  });
  @override
  List<Object> get props => [contacts];
}

class ContactlistLoading extends ContactTabsState {}

class FriendlistState extends ContactTabsState {
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

class PendinglistState extends ContactTabsState {
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

class BlocklistState extends ContactTabsState {
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
