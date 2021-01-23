import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app.dart';
import 'package:sqflite_repository/sqflite_repository.dart';

ContactRepository contactRepository = ContactRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  await Firebase.initializeApp();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    contactRepository: contactRepository,
  ));
}
