import 'package:flutter/material.dart';

ThemeData theme1(BuildContext context) {
  return ThemeData(
    // primaryColor: Colors.black,
    // accentColor: Colors.blueGrey.withOpacity(0.2),
    // backgroundColor: Colors.white,
    // scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFF100D0E))),
    primaryColor: Color(0xFFA7F5FF),
    errorColor: Colors.red,
    highlightColor: Colors.green,
    accentColor: Color(0xFF100D0E),
    backgroundColor: Color(0xFF10171E),
    scaffoldBackgroundColor: Color(0xFF10171E),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.4,
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.white,
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
          fontSize: 16,
          color: Colors.white.withOpacity(0.7),
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.none),
      contentPadding: EdgeInsets.all(12),
      counterStyle: TextStyle(color: Colors.teal),
      border: InputBorder.none,
      filled: true,
      fillColor: Color(0xFF2f3535),
    ),
  );
}
