import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_repository/sqflite_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;
  ContactBloc(this.contactRepository) : super(ContactState.loading());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is ContactLoaded) {
      yield* _mapContactLoadedToState();
    } else if (event is ContactAdded) {
      yield* _mapContactAddedToState(event);
    } else if (event is ContactUpdated) {
      yield* _mapContactUpdatedToState(event);
    } else if (event is ContactDeleted) {
      yield* _mapContactDeletedToState(event);
    } else if (event is DeleteAllContacts) {
      yield* _mapAllContactsDeletedToState();
    }
  }

  Stream<ContactState> _mapContactLoadedToState() async* {
    try {
      final contacts = await this.contactRepository.getAllContacts();
      // yield ContactLoadSuccess(
      //   contacts.map(ContactModel.fromDatabaseJson(contacts)).toList(),
      // );
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactAddedToState(ContactAdded event) async* {
    try {
      await this.contactRepository.addNewContact(event.contactModel);
      final contacts = await this.contactRepository.getAllContacts();
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactUpdatedToState(ContactUpdated event) async* {
    try {
      await this.contactRepository.updateContact(event.contactModel);
      final contacts = await this.contactRepository.getAllContacts();
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapContactDeletedToState(ContactDeleted event) async* {
    try {
      await this.contactRepository.deleteContactById(event.id);
      final contacts = await this.contactRepository.getAllContacts();
      yield ContactState.loadedSuccessfully(contacts);
    } catch (_) {
      yield ContactState.loadedWithError();
    }
  }

  Stream<ContactState> _mapAllContactsDeletedToState() async* {
    try {
      await this.contactRepository.deleteAllContacts();
      final contacts = await this.contactRepository.getAllContacts();
      yield ContactState.loadedSuccessfully(contacts);
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
//       yield* _mapContactLoadedToState();
//     } else if (event is ContactAdded) {
//       yield* _mapContactAddedToState(event);
//     } else if (event is ContactUpdated) {
//       yield* _mapContactUpdatedToState(event);
//     } else if (event is ContactDeleted) {
//       yield* _mapContactDeletedToState(event);
//     } else if (event is AllContactsDeleted) {
//       yield* _mapAllContactsDeletedToState();
//     }
//   }

//   Stream<ContactState> _mapContactLoadedToState() async* {
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

//   Stream<ContactState> _mapContactAddedToState(ContactAdded event) async* {
//     try {
//       final id = await this.contactRepository.addNewContact(event.contactModel);
//       yield ContactUpdatedSuccess(id);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapContactUpdatedToState(ContactUpdated event) async* {
//     try {
//       final id = await this.contactRepository.updateContact(event.contactModel);
//       yield ContactUpdatedSuccess(id);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapContactDeletedToState(ContactDeleted event) async* {
//     try {
//       final id = await this.contactRepository.deleteContactById(event.id);
//       yield ContactUpdatedSuccess(id);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }

//   Stream<ContactState> _mapAllContactsDeletedToState() async* {
//     try {
//       final result = await this.contactRepository.deleteAllContacts();
//       yield ContactUpdatedSuccess(result);
//     } catch (_) {
//       yield ContactLoadFailure();
//     }
//   }
// }
