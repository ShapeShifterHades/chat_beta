// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:void_chat_beta/ui/views/home_page.dart';

// import 'constants/constants.dart';
// import 'login/widgets/firebase_core_init.dart';
// import 'ui/views/contacts_view.dart';
// import 'ui/views/faq_view.dart';
// import 'ui/views/security_view.dart';
// import 'ui/views/settings_view.dart';

// class Router {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case messagesRoute:
//         return MaterialPageRoute(builder: (_) => HomePage());
//       case contactsRoute:
//         return MaterialPageRoute(builder: (_) => ContactsView());
//       case settingsRoute:
//         return MaterialPageRoute(builder: (_) => SettingsView());
//       case securityRoute:
//         return MaterialPageRoute(builder: (_) => SecurityView());
//       case faqRoute:
//         return MaterialPageRoute(builder: (_) => FaqView());

//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(
//                     body: Center(
//                   child: Text('No route defined for ${settings.name}'),
//                 )));
//     }
//   }
// }
