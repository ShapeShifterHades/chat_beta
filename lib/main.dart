import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/helper/authenticate.dart';
import 'package:void_chat_beta/helper/helper_functions.dart';

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
  HelperFunctions helperFunctions = HelperFunctions();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await helperFunctions.getUserLoggedInSharedPreference().then((value) {
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
            home: userIsLoggedIn ? ChatRoom() : Authenticate(),
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
