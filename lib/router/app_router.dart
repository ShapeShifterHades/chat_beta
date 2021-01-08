import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/contacts/contacts.dart';
import 'package:void_chat_beta/faq/faq.dart';
import 'package:void_chat_beta/home/home.dart';
import 'package:void_chat_beta/login/login.dart';
import 'package:void_chat_beta/security/security.dart';
import 'package:void_chat_beta/settings/settings.dart';
import 'package:void_chat_beta/signup/sign_up.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case contactsRoute:
        return MaterialPageRoute(builder: (_) => ContactsView());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsView());
      case securityRoute:
        return MaterialPageRoute(builder: (_) => SecurityView());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => FaqView());
        break;
      default:
        return null;
    }
  }

  void dispose() {}
}