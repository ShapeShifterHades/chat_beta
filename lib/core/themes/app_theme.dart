import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFFE6E8EB),
    accentColor: Color(0xFF002E3D), // Unused?
    backgroundColor: Color(0xFF282929),
    scaffoldBackgroundColor: Color(0xFF3B3B3B),
    highlightColor: Color(0xFFF28123),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.3,
          color: Color(0xFFE6E8EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.8,
          color: Color(0xFFF2F2F2),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.01,
          color: Color(0xFFBF4342),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.21,
          color: Color(0xFFC83E4D),
        ),
      ),
      errorStyle: TextStyle(
        color: Color(0xFFBF4342),
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
      hintStyle: TextStyle(
        color: Color(0xFFC83E4D),
        fontWeight: FontWeight.w100,
        fontSize: 15,
      ),
      labelStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFFF2F2F2),
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none),
      contentPadding: EdgeInsets.all(12),
      counterStyle: TextStyle(color: Colors.teal),
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.transparent,
    ),
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF282929),
    accentColor: Color(0xFFDBDBDB),
    backgroundColor: Color(0xFFFCF7FF),
    scaffoldBackgroundColor: Color(0xFFF2F2F2),
    highlightColor: Color(0xFFF28123),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.3,
          color: Color(0xFF282929),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.8,
          color: Color(0xFF282929),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.01,
          color: Color(0xFFBF4342),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.21,
          color: Color(0xFFC83E4D),
        ),
      ),
      errorStyle: TextStyle(
        color: Color(0xFFBF4342),
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
      hintStyle: TextStyle(
        color: Color(0xFFC83E4D),
        fontWeight: FontWeight.w100,
        fontSize: 15,
      ),
      labelStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF282929),
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none),
      contentPadding: EdgeInsets.all(12),
      counterStyle: TextStyle(color: Colors.teal),
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.transparent,
    ),
  );
}
