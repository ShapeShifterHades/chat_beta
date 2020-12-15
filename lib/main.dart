import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'widgets/auth/firebase_core_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        primaryColor: Color(0xFF10171E),
        primarySwatch: Colors.grey,
        backgroundColor: Color(0xFF10171E),
        accentColor: Colors.indigoAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.6,
              color: Color(0xFF8C8E8D),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF8C8E8D),
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
      home: FirebaseCoreInit(),
    );
  }
}
