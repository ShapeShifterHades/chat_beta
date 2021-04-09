import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:void_chat_beta/authentication/authentication.dart';

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
  final FirestoreContactRepository _firestoreContactRepository;
  String uid;
  Contact contact;

  @override
  FinduserState get initialState => FinduserState.initial();

  // @override
  // void onTransition(Transition<FinduserEvent, FinduserState> transition) {
  //   print(transition.toString());
  // }

  @override
  Stream<FinduserState> mapEventToState(FinduserEvent event) async* {
    yield FinduserState.loading();

    try {
      Contact contact = await _getSearchResults(event.query);
      yield FinduserState.success(contact);
    } catch (_) {
      yield FinduserState.error();
    }
  }

  Future<Contact> _getSearchResults(String query) async {
    try {
      contact = await _firestoreContactRepository.findIdByUsername(query, uid);
      return contact;
    } catch (e) {
      print(e);
    }
    return contact;
  }
}
