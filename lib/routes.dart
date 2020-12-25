import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants/constants.dart';
import 'ui/ui_screens/contacts_screen.dart';
import 'ui/ui_screens/faq_screen.dart';
import 'ui/ui_screens/security_screen.dart';
import 'ui/ui_screens/settings_screen.dart';
import 'ui/widgets/auth/firebase_core_init.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case messagesRoute:
        return MaterialPageRoute(builder: (_) => FirebaseCoreInit());
      case contactsRoute:
        return MaterialPageRoute(builder: (_) => ContactsScreen());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case securityRoute:
        return MaterialPageRoute(builder: (_) => SecurityScreen());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => FaqScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
