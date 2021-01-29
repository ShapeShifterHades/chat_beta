import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/contacts/contacts.dart';
import 'package:void_chat_beta/faq/faq.dart';
import 'package:void_chat_beta/home/home.dart';
import 'package:void_chat_beta/login/login.dart';
import 'package:void_chat_beta/security/security.dart';
import 'package:void_chat_beta/settings/settings.dart';
import 'package:void_chat_beta/signup/sign_up.dart';

class AppRouter {
  final FirestoreNewUserRepository firestoreNewUserRepository =
      FirestoreNewUserRepository();
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MessagesView());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case signupRoute:
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider.value(
            value: firestoreNewUserRepository,
            child: SignUpView(),
          ),
        );
      case contactsRoute:
        return MaterialPageRoute(
          builder: (_) => ContactsView(),
        );
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsView());
      case securityRoute:
        return MaterialPageRoute(builder: (_) => SecurityView());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => FaqView());
        break;
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
    }
  }

  void dispose() {}
}
