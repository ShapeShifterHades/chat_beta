import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/provider/auth_ui_provider.dart';
import 'package:void_chat_beta/ui/views/auth_view.dart';
import 'package:void_chat_beta/ui/views/chatlist_view.dart';
import 'package:void_chat_beta/ui/views/splash_view.dart';

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
                  return SplashView();
                }
                if (userSnapshot.hasData) {
                  return ChatlistView();
                }
                return ChangeNotifierProvider(
                    create: (context) => AuthUiProvider(),
                    builder: (context, _) {
                      return AuthView();
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
