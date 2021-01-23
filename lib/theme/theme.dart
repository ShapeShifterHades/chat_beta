import 'package:flutter/material.dart';

ThemeData theme1(BuildContext context, Brightness brightness) {
  bool isDark = brightness == Brightness.dark;
  return ThemeData(
    brightness: brightness,
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: Color(
          0xFF100D0E,
        ),
      ),
      subtitle1:
          TextStyle(color: isDark ? Color(0xFF1C2321) : Color(0xFF1C2321)),
      bodyText2: TextStyle(
        color: isDark ? Color(0xFFFBFBFD) : Color(0xFF1C2321),
        fontSize: 13,
      ),
      // headline3: TextStyle(color: )
    ),
    primaryColor: isDark ? Color(0xFFA7F5FF) : Color(0xFF1D80BE),
    errorColor: Color(0xFFC83E4D), // Submit fail color
    highlightColor: Color(0xFFF28123), //Submission in progress color
    accentColor: Color(0xFF4C956C), // Ready to submit color
    backgroundColor: isDark ? Color(0xFF10171E) : Color(0xFFFBFBFD),
    scaffoldBackgroundColor: Color(0xFF10171E),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.4,
          color: isDark ? Color(0xFFF2F2F2) : Color(0xFF1C2321),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: isDark ? Color(0xFFF2F2F2) : Color(0xFF1C2321),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.5,
          color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
        ),
      ),
      errorStyle: TextStyle(
        color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
        fontWeight: FontWeight.w100,
        fontSize: 15,
      ),
      hintStyle: TextStyle(
        color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
        fontWeight: FontWeight.w100,
        fontSize: 15,
      ),
      labelStyle: TextStyle(
          fontSize: 14,
          color: isDark ? Color(0xFFF2F2F2) : Color(0xFF1C2321),
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none),
      contentPadding: EdgeInsets.all(12),
      counterStyle: TextStyle(color: Colors.teal),
      border: InputBorder.none,
      filled: true,
      fillColor: isDark ? Color(0xFF2f3535) : Color(0xFFF2F2F2),
    ),
  );
}
