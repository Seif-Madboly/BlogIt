import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimaryColor = Color.fromARGB(255, 39, 10, 102);
  static const Color lightBackgroundColor = Colors.white;
  static const Color lightTextColor = Colors.black;

  // Dark Theme Colors
  static const Color darkPrimaryColor = Colors.grey;
static const Color darkBackgroundColor = Color(0xFF252525);
  static const Color darkTextColor = Colors.white;

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: lightBackgroundColor,

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightTextColor),
      bodyMedium:   TextStyle(color: lightTextColor),
    ),
    // Add other theme properties as needed
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    textTheme: const TextTheme(
      bodyLarge:   TextStyle(color: darkTextColor),
      bodyMedium: TextStyle(color: darkTextColor),
    ),
   );
}
