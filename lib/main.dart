import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/helper/authentication_helper.dart';
import 'package:void_chat_beta/helper/internal_database_functions.dart';

import 'helper/constants.dart';
import 'views/chat_rooms_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  InternalDbFunctions helperFunctions = InternalDbFunctions();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await helperFunctions.getUsersLoginStatus().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          print(snapshot.error);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Void chat beta',
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              primarySwatch: kPrimarySwatchColor,
              scaffoldBackgroundColor: kScaffoldColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: userIsLoggedIn ? ChatRoom() : AuthenticationHelper(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
