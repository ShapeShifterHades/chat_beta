part of 'contactlist_bloc.dart';

@immutable
abstract class ContactlistEvent extends Equatable {
  const ContactlistEvent();

  @override
  List<Object> get props => [];
}

class FriendlistClicked extends ContactlistEvent {}

class BlocklistClicked extends ContactlistEvent {}

class PendinglistClicked extends ContactlistEvent {}
