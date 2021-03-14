import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SearchUserFormBloc extends FormBloc<String, String> {
  FirestoreContactRepository firestoreContactRepository =
      FirestoreContactRepository();
  final username = TextFieldBloc(
    validators: [_min5Char],
    asyncValidatorDebounceTime: Duration(milliseconds: 0),
  );

  SearchUserFormBloc() {
    addFieldBlocs(fieldBlocs: [username]);
    username.addAsyncValidators(
      [_checkUsername],
    );
  }

  static String _min5Char(String username) {
    if (username.length < 5) return '';
    return null;
  }

  Future<String> _checkUsername(String username) async {
    await Future.delayed(Duration(microseconds: 300));
  }

  @override
  void onSubmitting() async {
    try {
      // Emmit here bloc ... found user
      print(username.value);
      var result =
          await firestoreContactRepository.findIdByUsername(username.value);
      print(result);
      emitSuccess();
    } catch (e) {
      print(e);
      emitFailure();
    }
  }
}
