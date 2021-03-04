import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';

part 'contactlist_event.dart';
part 'contactlist_state.dart';

class ContactlistBloc extends Bloc<ContactlistEvent, ContactlistState> {
  final ContactsBloc _contactsBloc;
  StreamSubscription contactsSubscription;
  ContactlistBloc(this._contactsBloc)
      : contactsSubscription = _contactsBloc.listen((state) {
          if (state is ContactsLoaded) {
            ContactsUpdated((_contactsBloc.state as ContactsLoaded).contacts);
          }
        }),
        super(FriendlistState(fullContactlist: []));

  @override
  ContactlistState get initialState {
    return _contactsBloc.state is ContactsLoaded
        ? FriendlistState(
            fullContactlist: (_contactsBloc.state as ContactsLoaded).contacts)
        : ContactlistLoading();
  }

  @override
  Stream<ContactlistState> mapEventToState(
    ContactlistEvent event,
  ) async* {
    if (event is FriendlistClicked) {
      yield _mapFriendlistClickedToState(event);
    } else if (event is BlocklistClicked) {
      yield _mapBlocklistClickedToState(event);
    } else if (event is PendinglistClicked) {
      yield _mapPendinglistClickedToState(event);
    }
  }

  _mapFriendlistClickedToState(FriendlistClicked event) {
    return FriendlistState(
        fullContactlist: (_contactsBloc.state as ContactsLoaded).contacts);
  }

  _mapBlocklistClickedToState(BlocklistClicked event) {
    return BlocklistState(
        blocklist: (_contactsBloc.state as ContactsLoaded).contacts);
  }

  _mapPendinglistClickedToState(PendinglistClicked event) {
    return PendinglistState(
        fullContactlist: (_contactsBloc.state as ContactsLoaded).contacts);
  }
}
