import 'package:flutter/material.dart';

ThemeData theme1(BuildContext context, Brightness brightness) {
  bool isDark = brightness == Brightness.dark;
  return ThemeData(
    brightness: brightness,
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: isDark ? Color(0xFFA7F5FF) : Color(0xFF10171E),
        // this is used for main drawer menu text,
        //[CustomFullFramePainter] main content frame
        //[ScreenTag] screen tag widget text
        fontSize: 13,
      ),
      bodyText2: TextStyle(
        color: isDark ? Color(0xFFFBFBFD) : Color(0xFF1C2321),
        fontSize: 13,
      ),
      subtitle1:
          TextStyle(color: isDark ? Color(0xFF1C2321) : Color(0xFF1C2321)),

      // headline3: TextStyle(color: )
    ),
    bottomAppBarColor: isDark
        ? Color(0xFF002E3D)
        : Color(0xFFF2F2F2), // Used in drawer backgrowndcolor
    cardColor: isDark ? Color(0xFF10171E) : Color(0xFFFBFBFD),
    primaryColor:
        isDark ? Color(0xFFA7F5FF) : Color(0xFF858585), // last light 1D80BE
    errorColor: Color(0xFFC83E4D), // Submit fail color
    highlightColor: Color(0xFFF28123), //Submission in progress color
    accentColor:
        isDark ? Color(0xFF002E3D) : Color(0xFFDBDBDB), // FORMS BACKGROUND
    backgroundColor: isDark
        ? Color(0xFF000000)
        : Color(
            0xFFFBFBFD), // main content colorbba (last version for bg dark - Color(0xFF10171E))
    scaffoldBackgroundColor: isDark
        ? Color(0xFF002E3D)
        : Color(0xFFF2F2F2), // Used in drawer backgrowndcolor,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.3,
          color: isDark ? Colors.transparent : Colors.transparent,
          // color: isDark ? Color(0xFFF2F2F2) : Color(0xFF1C2321),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.8,
          color: isDark ? Color(0xFFF2F2F2) : Color(0xFF1C2321),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: isDark ? Color(0xFFBF4342) : Colors.red[600],
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.8,
          color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
        ),
      ),
      errorStyle: TextStyle(
        color: isDark ? Color(0xFFBF4342) : Colors.red[600],
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
      hintStyle: TextStyle(
        color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
        fontWeight: FontWeight.w100,
        fontSize: 15,
      ),
      labelStyle: TextStyle(
          fontSize: 14,
          color: isDark ? Color(0xFFF2F2F2) : Color(0xFFFFFFFF),
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none),
      contentPadding: EdgeInsets.all(12),
      counterStyle: TextStyle(color: Colors.teal),
      border: InputBorder.none,
      filled: true,
      fillColor: isDark
          ? Colors.transparent
          : Colors.transparent, // light - accent color
    ),
    accentIconTheme: IconThemeData(color: Colors.red),
    primarySwatch: Colors.red,
  );
}
