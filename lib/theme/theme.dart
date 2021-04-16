import 'package:flutter/material.dart';
// MainUI:
//
// backgroundColor - content background[UI],
// primaryColor - contrasting with bg
// scaffoldBackgroundColor

ThemeData theme1(BuildContext context, Brightness brightness) {
  bool isDark = brightness == Brightness.dark;

  ThemeData darkTheme = ThemeData(
    // canvasColor: Colors.transparent,

    brightness: brightness,
    primarySwatch: Colors.grey,
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
  ThemeData lightTheme = ThemeData(
    // canvasColor: Colors.transparent,
    brightness: brightness,
    primarySwatch: Colors.grey,
    primaryColor: Color(0xFF57756E),
    accentColor: Color(0xFFDBDBDB),
    backgroundColor: Color(0xFFFCF7FF),
    scaffoldBackgroundColor: Color(0xFFF2F2F2),
    highlightColor: Color(0xFFF28123),
  );

  return isDark ? darkTheme : lightTheme;

//   ThemeData(
//     brightness: brightness,
//     primaryTextTheme: TextTheme(
//       bodyText1: TextStyle(
//         color: isDark ? Color(0xFFE6E8EB) : Color(0xFF10171E),
//         fontSize: 13,
//       ),
//       bodyText2: TextStyle(
//         color: isDark ? Color(0xFFFBFBFD) : Color(0xFF1C2321),
//         fontSize: 13,
//       ),
//       subtitle1:
//           TextStyle(color: isDark ? Color(0xFF1C2321) : Color(0xFF1C2321)),
//     ),
//     bottomAppBarColor: isDark ? Color(0xFF002E3D) : Color(0xFFF2F2F2),
//     cardColor: isDark ? Color(0xFF10171E) : Color(0xFFFBFBFD),
//     primaryColor: isDark ? Color(0xFFA7F5FF) : Color(0xFF57756E),
//     errorColor: Color(0xFFC83E4D),
//     highlightColor: Color(0xFFF28123),
//     accentColor: isDark ? Color(0xFF002E3D) : Color(0xFFDBDBDB),
//     backgroundColor: isDark ? Color(0xFF282929) : Color(0xFFFCF7FF),
//     scaffoldBackgroundColor: isDark ? Color(0xFF3B3B3B) : Color(0xFFF2F2F2),
//     inputDecorationTheme: InputDecorationTheme(
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           width: 0.3,
//           color: isDark ? Colors.transparent : Colors.transparent,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           width: 0.8,
//           color: isDark ? Color(0xFFF2F2F2) : Color(0xFF1C2321),
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           width: 0.01,
//           color: isDark ? Color(0xFFBF4342) : Colors.red[600],
//         ),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           width: 0.21,
//           color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
//         ),
//       ),
//       errorStyle: TextStyle(
//         color: isDark ? Color(0xFFBF4342) : Colors.red[600],
//         fontWeight: FontWeight.w300,
//         fontSize: 15,
//       ),
//       hintStyle: TextStyle(
//         color: isDark ? Color(0xFFC83E4D) : Colors.red[600],
//         fontWeight: FontWeight.w100,
//         fontSize: 15,
//       ),
//       labelStyle: TextStyle(
//           fontSize: 14,
//           color: isDark ? Color(0xFFF2F2F2) : Color(0xFFFFFFFF),
//           fontWeight: FontWeight.w500,
//           decoration: TextDecoration.none),
//       contentPadding: EdgeInsets.all(12),
//       counterStyle: TextStyle(color: Colors.teal),
//       border: InputBorder.none,
//       filled: true,
//       fillColor: isDark ? Colors.transparent : Colors.transparent,
//     ),
//   );
}
