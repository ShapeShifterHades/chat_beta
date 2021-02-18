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
  StreamSubscription _contactSubscription;

  ContactBloc(
    this._firestoreContactRepository,
    this._authenticationBloc,
  )   : assert(_authenticationBloc != null),
        assert(_firestoreContactRepository != null),
        super(ContactsLoading());

  @override
  Stream<ContactsState> mapEventToState(ContactEvent event) async* {
    if (event is LoadContacts) {
      yield* _mapLoadContactsToState();
    } else if (event is SendContactRequest) {
      yield* _mapSendContactRequestToState(event);
    } else if (event is AcceptContactRequest) {
      yield* _mapAcceptContactRequestToState(event);
    } else if (event is RemoveContactRequest) {
      yield* _mapRemoveContactRequestToState(event);
    } else if (event is RejectContactRequest) {
      yield* _mapRejectContactRequestToState(event);
    } else if (event is BlockContact) {
      yield* _mapBlockContactToState(event);
    } else if (event is ContactsUpdated) {
      yield* _mapContactsUpdatedToState(event);
    }
  }

  Stream<ContactsState> _mapLoadContactsToState() async* {
    _contactSubscription?.cancel();
    _contactSubscription = _firestoreContactRepository.contacts().listen(
          (contacts) => add(ContactsUpdated(contacts)),
        );
    // try {
    //   final contacts = await this
    //       .firestoreContactRepository
    //       .contacts(uid: _authenticationBloc.state.user.id);
    //   yield ContactsState.loadedSuccessfully(contacts);
    // } catch (_) {
    //   yield ContactsState.loadedWithError();
    // }
  }

  Stream<ContactsState> _mapSendContactRequestToState(
      SendContactRequest event) async* {
    await this._firestoreContactRepository.sendRequest(
        contactId: event.contactId,
        uid: _authenticationBloc.state.user.id,
        message: event.message);
  }

  Stream<ContactsState> _mapAcceptContactRequestToState(
      AcceptContactRequest event) async* {
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

  Stream<ContactsState> _mapRejectContactRequestToState(
      RejectContactRequest event) async* {
    await this._firestoreContactRepository.rejectContact(
          contactId: event.contactId,
          uid: _authenticationBloc.state.user.id,
        );
  }

  Stream<ContactsState> _mapBlockContactToState(BlockContact event) async* {
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

  @override
  Future<void> close() {
    _contactSubscription?.cancel();
    return super.close();
  }
}
