part of 'contacts_tabs_bloc.dart';

@immutable
abstract class ContactsTabsEvent extends Equatable {
  const ContactsTabsEvent();

  @override
  List<Object> get props => [];
}

class ShowContactsFriendlist extends ContactsTabsEvent {}

class ShowContactsBlocklist extends ContactsTabsEvent {}

class ShowContactsPendinglist extends ContactsTabsEvent {}
