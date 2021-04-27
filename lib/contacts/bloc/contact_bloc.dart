import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/authentication/authentication.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactsState> {
  final AuthenticationBloc _authenticationBloc;
  final FirestoreContactRepository _firestoreContactRepository;
  StreamSubscription? _contactSubscription;

  ContactBloc(
    FirestoreContactRepository firestoreContactRepository,
    AuthenticationBloc authenticationBloc,
  )   : assert(authenticationBloc != null),
        assert(firestoreContactRepository != null),
        _firestoreContactRepository = firestoreContactRepository,
        _authenticationBloc = authenticationBloc,
        super(ContactsAreLoading());

  @override
  Stream<ContactsState> mapEventToState(ContactEvent event) async* {
    if (event is LoadContacts) {
      yield* _mapLoadContactsToState();
    } else if (event is SendFriendshipRequest) {
      yield* _mapSendFriendshipRequestToState(event);
    } else if (event is AcceptFriendshipRequest) {
      yield* _mapAcceptFriendshipRequestToState(event);
    } else if (event is RemoveContactRequest) {
      yield* _mapRemoveContactRequestToState(event);
    } else if (event is AddToBlocklist) {
      yield* _mapAddToBlocklistToState(event);
    } else if (event is RemoveFromBlocklist) {
      yield* _mapRemoveFromBlocklistToState(event);
    } else if (event is ContactsUpdated) {
      yield* _mapContactsUpdatedToState(event);
    }
  }

  Stream<ContactsState> _mapLoadContactsToState() async* {
    _contactSubscription?.cancel();
    _contactSubscription = _firestoreContactRepository
        .contacts(uid: _authenticationBloc.state.user.id)
        .listen(
          (contacts) => add(ContactsUpdated(contacts)),
        );
  }

  Stream<ContactsState> _mapSendFriendshipRequestToState(
      SendFriendshipRequest event) async* {
    await this._firestoreContactRepository.sendRequest(
        contactId: event.contactId,
        uid: _authenticationBloc.state.user.id,
        message: event.message);
  }

  Stream<ContactsState> _mapAcceptFriendshipRequestToState(
      AcceptFriendshipRequest event) async* {
    await this._firestoreContactRepository.acceptRequest(
          contactId: event.contactId,
          uid: _authenticationBloc.state.user.id,
        );
  }

  Stream<ContactsState> _mapRemoveContactRequestToState(
      RemoveContactRequest event) async* {
    await this._firestoreContactRepository.removeRequest(
          contactId: event.contactId,
          uid: _authenticationBloc.state.user.id,
        );
  }

  Stream<ContactsState> _mapRemoveFromBlocklistToState(
      RemoveFromBlocklist event) async* {
    await this._firestoreContactRepository.removeFromBlocklist(
          contactId: event.contactId,
          uid: _authenticationBloc.state.user.id,
        );
  }

  Stream<ContactsState> _mapAddToBlocklistToState(AddToBlocklist event) async* {
    await this._firestoreContactRepository.blockContact(
          contactId: event.contactId,
          uid: _authenticationBloc.state.user.id,
        );
  }

  /// Contactlist of a user has been updated
  Stream<ContactsState> _mapContactsUpdatedToState(
      ContactsUpdated event) async* {
    yield ContactsLoaded(event.contacts);
  }

  // Stream<ContactsState> _mapFindUsernameByIdTpState(
  //     FindUsernameById event) async* {
  //   await this._firestoreContactRepository.findUsernameById(event.contactId);
  // }

  @override
  Future<void> close() {
    _contactSubscription?.cancel();
    return super.close();
  }
}
