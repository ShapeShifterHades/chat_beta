import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../screens/auth_screen.dart';

class FirebaseCoreInit extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            child: Text('Error happend'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
