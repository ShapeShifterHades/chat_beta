import 'package:flutter/material.dart';

import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/routes.dart';

import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      title: 'FlutterChat',
      theme: ThemeData(
        primaryColor: Color(0xFF10171E),
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: kMainBgColor,
        backgroundColor: Color(0xFF10171E),
        accentColor: Colors.indigoAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.4,
              color: kSecondaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: kSecondaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: Colors.red[700],
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.red[700],
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red[700],
            fontWeight: FontWeight.w100,
            fontSize: 15,
          ),
          hintStyle: TextStyle(
            color: Colors.red[700],
            fontWeight: FontWeight.w100,
            fontSize: 15,
          ),
          labelStyle: TextStyle(
              color: Color(0xFF8C8E8D),
              fontWeight: FontWeight.w300,
              decoration: TextDecoration.none),
          contentPadding: EdgeInsets.all(12),
          counterStyle: TextStyle(color: Colors.teal),
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFF2f3535),
        ),
      ),
      initialRoute: messagesRoute,
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }
}
