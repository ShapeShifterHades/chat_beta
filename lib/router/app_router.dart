import 'package:flutter/material.dart';
import 'package:void_chat_beta/authentication/authentication.dart';
import 'package:void_chat_beta/faq/faq.dart';
import 'package:void_chat_beta/home/home.dart';
import 'package:void_chat_beta/login/view/login_view.dart';
import 'package:void_chat_beta/security/security.dart';
import 'package:void_chat_beta/settings/settings.dart';
import 'package:void_chat_beta/signup/view/signup_view.dart';
import 'package:void_chat_beta/splash/splash.dart';

class AppRouter {
  Route onGenerateRoute(
    RouteSettings settings,
    AuthenticationState state,
  ) {
    print('${settings.name},  ${state.status}');

    final loginRoute = MaterialPageRoute<void>(
      builder: (context) => LoginView(),
      settings: RouteSettings(name: '/login'),
    );

    final contactsRoute = MaterialPageRoute<void>(
      builder: (context) => MessagesView(),
      settings: RouteSettings(name: '/contacts'),
    );

    final settingsRoute = MaterialPageRoute<void>(
      builder: (context) => SettingsView(),
      settings: RouteSettings(name: '/settings'),
    );

    final securityRoute = MaterialPageRoute<void>(
      builder: (context) => SecurityView(),
      settings: RouteSettings(name: '/security'),
    );

    final faqRoute = MaterialPageRoute<void>(
      builder: (context) => FaqView(),
      settings: RouteSettings(name: '/faq'),
    );

    final signupRoute = MaterialPageRoute<void>(
      builder: (context) => SignUpView(),
      settings: RouteSettings(name: '/signup'),
    );

    final splashRoute = MaterialPageRoute<void>(
      builder: (context) => SplashView(),
      settings: RouteSettings(name: '/splash'),
    );

    if (settings.name == '/login') {
      return loginRoute;
    }

    if (settings.name == '/contacts') {
      return contactsRoute;
    }

    if (settings.name == '/settings') {
      return settingsRoute;
    }
    if (settings.name == '/security') {
      return securityRoute;
    }
    if (settings.name == '/faq') {
      return faqRoute;
    }
    if (settings.name == '/signup') {
      return signupRoute;
    }

    if (settings.name == '/splash') {
      return splashRoute;
    }

    if (settings.name == '/' || settings.name == '/home') {
      if (state.status != AuthenticationStatus.authenticated) {
        return loginRoute;
      }
      return MaterialPageRoute<void>(
        // settings: RouteSettings(name: '/'),
        settings: RouteSettings(name: '/contacts'),
        builder: (context) => MessagesView(),
      );
    }

    return MaterialPageRoute<void>(builder: (_) => Text('NOT FOUND'));
  }

  void dispose() {}
}
