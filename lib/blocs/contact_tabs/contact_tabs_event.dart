part of 'contact_tabs_bloc.dart';

@immutable
abstract class ContactTabsEvent extends Equatable {
  const ContactTabsEvent();

  @override
  List<Object> get props => [];
}

class FriendlistClicked extends ContactTabsEvent {}

class BlocklistClicked extends ContactTabsEvent {}

class PendinglistClicked extends ContactTabsEvent {}
