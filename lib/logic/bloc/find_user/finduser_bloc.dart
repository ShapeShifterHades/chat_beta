import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

part 'finduser_event.dart';
part 'finduser_state.dart';

class FinduserBloc extends Bloc<FinduserEvent, FinduserState> {
  FinduserBloc(
    this._authenticationBloc,
    this._firestoreContactRepository,
  ) : super(FinduserState.initial()) {
    uid = _authenticationBloc.state.user.id;
  }

  final AuthenticationBloc _authenticationBloc;
  final FirestoreContactRepository? _firestoreContactRepository;
  late String uid;
  Contact? contact;

  FinduserState get initialState => FinduserState.initial();

  // @override
  // void onTransition(Transition<FinduserEvent, FinduserState> transition) {
  //   print(transition.toString());
  // }

  @override
  Stream<FinduserState> mapEventToState(FinduserEvent event) async* {
    if (event is QueryEvent) {
      yield FinduserState.loading();

      try {
        final Contact? contact = await _getSearchResults(event.query);
        yield FinduserState.success(contact);
      } catch (_) {
        yield FinduserState.error();
      }
    } else if (event is ResetEvent) yield FinduserState.initial();
  }

  Future<Contact?> _getSearchResults(String query) async {
    try {
      return contact =
          await _firestoreContactRepository?.findIdByUsername(query, uid);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return contact;
  }
}
