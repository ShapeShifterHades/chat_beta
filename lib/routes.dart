import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants/constants.dart';
import 'ui/views/contacts_view.dart';
import 'ui/views/faq_view.dart';
import 'ui/views/security_view.dart';
import 'ui/views/settings_view.dart';
import 'ui/widgets/auth/firebase_core_init.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case messagesRoute:
        return MaterialPageRoute(builder: (_) => FirebaseCoreInit());
      case contactsRoute:
        return MaterialPageRoute(builder: (_) => ContactsView());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsView());
      case securityRoute:
        return MaterialPageRoute(builder: (_) => SecurityView());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => FaqView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
