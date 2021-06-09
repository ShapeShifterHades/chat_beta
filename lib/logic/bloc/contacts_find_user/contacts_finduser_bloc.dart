import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

part 'contacts_finduser_event.dart';
part 'contacts_finduser_state.dart';

class ContactsFinduserBloc
    extends Bloc<ContactsFinduserEvent, ContactsFinduserState> {
  ContactsFinduserBloc({
    required this.authenticationBloc,
    required this.firestoreContactRepository,
  }) : super(ContactsFinduserState.initial()) {
    uid = authenticationBloc.state.user.id;
  }

  final AuthenticationBloc authenticationBloc;
  final FirestoreContactRepository firestoreContactRepository;
  late String uid;
  Contact? contact;

  ContactsFinduserState get initialState => ContactsFinduserState.initial();

  @override
  Stream<ContactsFinduserState> mapEventToState(
      ContactsFinduserEvent event) async* {
    if (event is QueryEvent) {
      yield ContactsFinduserState.loading();

      try {
        final Contact? contact = await _getSearchResults(event.query);
        yield ContactsFinduserState.success(contact);
      } catch (_) {
        yield ContactsFinduserState.error();
      }
    } else if (event is ResetEvent) yield ContactsFinduserState.initial();
  }

  Future<Contact?> _getSearchResults(String query) async {
    try {
      return contact =
          await firestoreContactRepository.findIdByUsername(query, uid);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return contact;
  }
}
