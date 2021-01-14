import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'sqflite/repository/contact_repository.dart';

ContactRepository contactRepository = ContactRepository();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    contactRepository: contactRepository,
  ));
}
