import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<FriendEvent, ContactState> {
  final FirestoreContactRepository firestoreContactRepository;
  ContactBloc(this.firestoreContactRepository) : super(ContactState.loading());

  @override
  Stream<ContactState> mapEventToState(FriendEvent event) async* {
    if (event is FriendListLoaded) {
      yield* _mapFriendListLoadedToState();
    } else if (event is FriendRequestAccepted) {
      yield* _mapFriendRequestAcceptedToState(event);
    } else if (event is FriendRequestSent) {
      yield* _mapFriendRequestSentToState(event);
    } else if (event is FriendRequestRejected) {
      yield* _mapFriendRequestRejectedToState(event);
    } else if (event is FriendRemovedFromList) {
      yield* _mapFriendRemovedFromListToState(event);
    }
  }

  Stream<ContactState> _mapFriendListLoadedToState() async* {
    try {
      final contacts = this.firestoreContactRepository.contacts();
      // yield ContactLoadSuccess(
      //   contacts.map(ContactModel.fromDatabaseJson(contacts)).toList(),
      // );
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapFriendRequestAcceptedToState(FriendRequestAccepted event) async* {
    try {
      // await this.firestoreContactRepository.addNewContact(event.contactModel);
      // final contacts = await this.firestoreContactRepository.getAllContacts();
      // yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapFriendRequestSentToState(FriendRequestSent event) async* {
    try {
      // await this.firestoreContactRepository.updateContact(event.contactModel);
      // final contacts = await this.firestoreContactRepository.getAllContacts();
      // yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapFriendRequestRejectedToState(FriendRequestRejected event) async* {
    try {
      // await this.firestoreContactRepository.deleteContactById(event.id);
      // final contacts = await this.firestoreContactRepository.getAllContacts();
      // yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapFriendRemovedFromListToState(FriendRemovedFromList event) async* {
    try {
      // await this.firestoreContactRepository.deleteAllContacts();
      // final contacts = await this.firestoreContactRepository.getAllContacts();
      // yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }
}

// class ContactBloc extends Bloc<ContactEvent, ContactState> {
//   final ContactRepository contactRepository;
//   ContactBloc(this.contactRepository) : super(ContactLoadInProgress());

//   @override
//   Stream<ContactState> mapEventToState(
//     ContactEvent event,
//   ) async* {
//     if (event is ContactLoaded) {
//       yield* _mapFriendListLoadedToState();
//     } else if (event is ContactAdded) {
//       yield* _mapFriendRequestAcceptedToState(event);
//     } else if (event is ContactUpdated) {
//       yield* _mapFriendRequestSentToState(event);
//     } else if (event is ContactDeleted) {
//       yield* _mapFriendRequestRejectedToState(event);
//     } else if (event is AllContactsDeleted) {
//       yield* _mapFriendRemovedFromListToState();
//     }
//   }

//   Stream<ContactState> _mapFriendListLoadedToState() async* {
//     try {
//       final contacts = await this.contactRepository.getAllContacts();
//       // yield ContactLoadSuccess(
//       //   contacts.map(ContactModel.fromDatabaseJson(contacts)).toList(),
//       // );
//       yield ContactLoadSuccess(contacts);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapFriendRequestAcceptedToState(ContactAdded event) async* {
//     try {
//       final id = await this.contactRepository.addNewContact(event.contactModel);
//       yield ContactUpdatedSuccess(id);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapFriendRequestSentToState(ContactUpdated event) async* {
//     try {
//       final id = await this.contactRepository.updateContact(event.contactModel);
//       yield ContactUpdatedSuccess(id);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapFriendRequestRejectedToState(ContactDeleted event) async* {
//     try {
//       final id = await this.contactRepository.deleteContactById(event.id);
//       yield ContactUpdatedSuccess(id);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapFriendRemovedFromListToState() async* {
//     try {
//       final result = await this.contactRepository.deleteAllContacts();
//       yield ContactUpdatedSuccess(result);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }
// }
