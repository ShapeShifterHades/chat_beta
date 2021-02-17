import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/authentication/authentication.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final AuthenticationBloc _authenticationBloc;
  final FirestoreContactRepository firestoreContactRepository;
  StreamSubscription _contactSubscription;

  ContactBloc(
    this.firestoreContactRepository,
    this._authenticationBloc,
  )   : assert(_authenticationBloc != null),
        assert(firestoreContactRepository != null),
        super(ContactState.loading());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is ContactListLoaded) {
      yield* _mapContactListLoadedToState();
    } else if (event is ContactRequestSent) {
      yield* _mapContactRequestSentToState(event);
    } else if (event is ContactAcceptedRequest) {
      yield* _mapContactAcceptedRequestToState(event);
    } else if (event is ContactRemovedRequest) {
      yield* _mapContactRemovedRequestToState(event);
    } else if (event is ContactRejectedRequest) {
      yield* _mapContactRejectedRequestToState(event);
    } else if (event is ContactBlocked) {
      yield* _mapContactBlockedToState(event);
    } else if (event is ContactsUpdated) {
      yield* _mapContactsUpdatedToState(event);
    }
  }

  Stream<ContactState> _mapContactListLoadedToState() async* {
    _contactSubscription?.cancel();
    _contactSubscription = firestoreContactRepository.contacts().listen(
          (contact) => add(ContactsUpdated(todos)),
        );
    try {
      final contacts = await this
          .firestoreContactRepository
          .contacts(uid: _authenticationBloc.state.user.id);
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactRequestSentToState(
      ContactRequestSent event) async* {
    try {
      await this.firestoreContactRepository.sendRequest(
          contactId: event.contactId,
          uid: _authenticationBloc.state.user.id,
          message: event.message);
      final contacts = this
          .firestoreContactRepository
          .contacts(uid: _authenticationBloc.state.user.id);
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactAcceptedRequestToState(
      ContactAcceptedRequest event) async* {
    try {
      await this.firestoreContactRepository.acceptRequest(
            contactId: event.contactId,
            uid: _authenticationBloc.state.user.id,
          );
      final contacts = this
          .firestoreContactRepository
          .contacts(uid: _authenticationBloc.state.user.id);
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactRemovedRequestToState(
      ContactRemovedRequest event) async* {
    try {
      await this.firestoreContactRepository.removeRequest(
            contactId: event.contactId,
            uid: _authenticationBloc.state.user.id,
          );
      final contacts = this
          .firestoreContactRepository
          .contacts(uid: _authenticationBloc.state.user.id);
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactRejectedRequestToState(
      ContactRejectedRequest event) async* {
    try {
      await this.firestoreContactRepository.rejectContact(
            contactId: event.contactId,
            uid: _authenticationBloc.state.user.id,
          );
      final contacts = this
          .firestoreContactRepository
          .contacts(uid: _authenticationBloc.state.user.id);
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactBlockedToState(ContactBlocked event) async* {
    try {
      await this.firestoreContactRepository.blockContact(
            contactId: event.contactId,
            uid: _authenticationBloc.state.user.id,
          );
      final contacts = this
          .firestoreContactRepository
          .contacts(uid: _authenticationBloc.state.user.id);
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  /// Contactlist of a user has been updated
  Stream<ContactState> _mapContactsUpdatedToState(
      ContactsUpdated event) async* {
    yield ContactState.loadedSuccessfully(event.contacts);
  }

  @override
  Future<void> close() {
    _contactSubscription?.cancel();
    return super.close();
  }
}
