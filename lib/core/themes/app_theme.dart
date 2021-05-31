import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFE6E8EB),
    backgroundColor: const Color(0xFF282929),
    colorScheme: ColorScheme(
      secondary: Color(0xFFBF4342),
      surface: Colors.white,
      onSurface: Colors.black,
      primary: Colors.red,
      onPrimary: Colors.black,
      primaryVariant: Colors.orange,
      background: Colors.red,
      onBackground: Colors.black,
      error: Colors.black,
      onError: Colors.white,
      onSecondary: Colors.white,
      secondaryVariant: Colors.deepOrange,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF3B3B3B),
    highlightColor: const Color(0xFFF28123),
    inputDecorationTheme: const InputDecorationTheme(
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
    colorScheme: const ColorScheme(
      secondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      primary: Color(0xFFFCF7FF),
      onPrimary: Colors.black,
      primaryVariant: Color(0xFFFCF7FF),
      background: Color(0xFFFCF7FF),
      onBackground: Colors.black,
      error: Colors.black,
      onError: Colors.white,
      onSecondary: Colors.white,
      secondaryVariant: Color(0xFFFCF7FF),
      brightness: Brightness.light,
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFF282929),
    backgroundColor: const Color(0xFFFCF7FF),
    scaffoldBackgroundColor: const Color(0xFFF2F2F2),
    highlightColor: const Color(0xFFF28123),
    inputDecorationTheme: const InputDecorationTheme(
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
