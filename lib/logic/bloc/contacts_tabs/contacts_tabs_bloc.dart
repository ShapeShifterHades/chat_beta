import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/logic/bloc/contacts/contacts_bloc.dart';

part 'contacts_tabs_event.dart';
part 'contacts_tabs_state.dart';

class ContactsTabsBloc extends Bloc<ContactsTabsEvent, ContactsTabsState> {
  final ContactsBloc _contactsBloc;
  StreamSubscription contactsSubscription;
  ContactsTabsBloc(this._contactsBloc)
      : contactsSubscription = _contactsBloc.stream.listen((state) {
          if (state is ContactsLoaded) {
            ContactsUpdated((_contactsBloc.state as ContactsLoaded).contacts);
          }
        }),
        super(FriendlistState(fullContactlist: const []));

  @override
  // ignore: override_on_non_overriding_member
  ContactsTabsState get initialState {
    return _contactsBloc.state is ContactsLoaded
        ? FriendlistState(
            fullContactlist: (_contactsBloc.state as ContactsLoaded).contacts)
        : ContactlistLoading();
  }

  @override
  Stream<ContactsTabsState> mapEventToState(
    ContactsTabsEvent event,
  ) async* {
    if (event is ShowContactsFriendlist) {
      yield _mapFriendlistClickedToState(event);
    } else if (event is ShowContactsBlocklist) {
      yield _mapBlocklistClickedToState(event);
    } else if (event is ShowContactsPendinglist) {
      yield _mapPendinglistClickedToState(event);
    }
  }

  ContactsTabsState _mapFriendlistClickedToState(ShowContactsFriendlist event) {
    return FriendlistState(
        fullContactlist: (_contactsBloc.state as ContactsLoaded).contacts);
  }

  ContactsTabsState _mapBlocklistClickedToState(ShowContactsBlocklist event) {
    return BlocklistState(
        blocklist: (_contactsBloc.state as ContactsLoaded).contacts);
  }

  ContactsTabsState _mapPendinglistClickedToState(
      ShowContactsPendinglist event) {
    return PendinglistState(
        fullContactlist: (_contactsBloc.state as ContactsLoaded).contacts);
  }
}
