part of 'contacts_tabs_bloc.dart';

enum ContactsStatus { friendlist, blocklist, pending, loading }

abstract class ContactsTabsState extends Equatable {
  const ContactsTabsState();
  @override
  List<Object> get props => [];
}

class ContactlistLoading extends ContactsTabsState {}

class FriendlistState extends ContactsTabsState {
  final List<Contact> fullContactlist;
  final List<Contact> contacts;
  FriendlistState({
    required this.fullContactlist,
  }) : contacts = fullContactlist
            .where((contact) => contact.status == 'friend')
            .toList();
  @override
  List<Object> get props => [contacts];
}

class PendinglistState extends ContactsTabsState {
  final List<Contact> fullContactlist;
  final List<Contact> contacts;

  PendinglistState({
    required this.fullContactlist,
  }) : contacts = fullContactlist
            .where((contact) => contact.status == 'pending')
            .toList();
  @override
  List<Object> get props => [contacts];
}

class BlocklistState extends ContactsTabsState {
  final List<Contact> blocklist;
  final List<Contact> contacts;

  BlocklistState({
    required this.blocklist,
  }) : contacts =
            blocklist.where((contact) => contact.status == 'blocked').toList();
  @override
  List<Object> get props => [contacts];
}
