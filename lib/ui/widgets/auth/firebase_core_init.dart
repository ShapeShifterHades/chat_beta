import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/provider/auth_ui_provider.dart';
import 'package:void_chat_beta/ui/ui_screens/auth_screen.dart';
import 'package:void_chat_beta/ui/ui_screens/chatlist_screen.dart';
import 'package:void_chat_beta/ui/ui_screens/splash_screen.dart';

class FirebaseCoreInit extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Text('Error happend while connecting to FireAuth'),
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
                return ChangeNotifierProvider(
                    create: (context) => AuthUiProvider(),
                    builder: (context, _) {
                      return AuthScreen();
                    });
              });
        }
        return Container(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
