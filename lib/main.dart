import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app.dart';


FirestoreContactRepository _firestoreContactRepository =
    FirestoreContactRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  await Firebase.initializeApp();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    firestoreContactRepository: _firestoreContactRepository,
  ));
}
