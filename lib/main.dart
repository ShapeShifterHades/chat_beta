import 'package:flutter/material.dart';

import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/routes.dart' as router;
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme1(context),
      darkTheme: theme1(context),
      initialRoute: messagesRoute,
      onGenerateRoute: router.Router.generateRoute,
      // navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
