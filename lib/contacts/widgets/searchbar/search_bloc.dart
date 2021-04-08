// import '../../../authentication/authentication.dart';
// import 'package:firestore_repository/firestore_repository.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';

// class SearchUserFormBloc extends FormBloc<String, String> {
//   final AuthenticationBloc authenticaionBloc;

//   FirestoreContactRepository firestoreContactRepository =
//       FirestoreContactRepository();
//   final username = TextFieldBloc(
//     validators: [_min5Char],
//     asyncValidatorDebounceTime: Duration(milliseconds: 600),
//   );

//   SearchUserFormBloc({this.authenticaionBloc}) {
//     addFieldBlocs(fieldBlocs: [username]);
//     username.addAsyncValidators(
//       [_checkUsername],
//     );
//   }

//   static String _min5Char(String username) {
//     if (username.length < 5) return 'WTF NIGGA';
//     return null;
//   }

//   Future<String> _checkUsername(String username) async {
//     try {
//       // Contact result = await firestoreContactRepository.findIdByUsername(
//       //     username, authenticaionBloc.state.user.id);
//       return 'EXISTS!!!';
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   @override
//   void onSubmitting() async {
//     try {
//       // Emmit here bloc ... found user
//       print(authenticaionBloc.state.user.id);
//       var result = await firestoreContactRepository.findIdByUsername(
//           username.value, authenticaionBloc.state.user.id);
//       print('Bitch! $result');
//       username.clear();
//       emitSuccess();
//     } catch (e) {
//       print('For fuck sake! $e');
//       emitFailure();
//     }
//   }
// }
