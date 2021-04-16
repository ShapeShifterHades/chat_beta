import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  FirestoreNewUserRepository _firestoreNewUserRepository =
      FirestoreNewUserRepository();
  FirestoreContactRepository _firestoreContactRepository =
      FirestoreContactRepository();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(App(
    authenticationRepository: _authenticationRepository,
    firestoreContactRepository: _firestoreContactRepository,
    firestoreNewUserRepository: _firestoreNewUserRepository,
  ));
}
