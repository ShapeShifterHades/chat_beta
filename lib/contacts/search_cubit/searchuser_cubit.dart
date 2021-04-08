import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';
import 'package:void_chat_beta/authentication/models/username.dart';

part 'searchuser_state.dart';

class SearchUsernameCubit extends Cubit<SearchUsernameState> {
  SearchUsernameCubit(
      this._authenticationBloc, this._firestoreContactRepository)
      : assert(_authenticationBloc != null),
        assert(_firestoreContactRepository != null),
        super(const SearchUsernameState()) {
    uid = _authenticationBloc.state.user.id;
  }
  final AuthenticationBloc _authenticationBloc;
  final FirestoreContactRepository _firestoreContactRepository;
  String uid;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
        state.copyWith(username: username, status: Formz.validate([username])));

    Future<Contact> findUsername() async {
      if (!state.status.isValidated) return null;
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        Contact _contact = await _firestoreContactRepository.findIdByUsername(
            username.value, uid);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));

        return _contact;
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
      return null;
    }
  }
}
