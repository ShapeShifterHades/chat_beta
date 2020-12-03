import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:void_chat_beta/screens/chatlist_screen.dart';
import 'package:void_chat_beta/screens/splash_screen.dart';
import '../../screens/auth_screen.dart';

class FirebaseCoreInit extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Text('Error happend'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                if (userSnapshot.hasData) {
                  return ChatlistScreen();
                }
                return AuthScreen();
              });
        }
        return Container(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
