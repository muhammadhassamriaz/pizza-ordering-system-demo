import 'package:flutter/material.dart';
import 'package:pizza/utils/constants.dart';

class Style {
  const Style._();

  static const textTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(Constants.kTextColor)),
    headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: Color(Constants.kTextColor)),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      color: Color(Constants.kTextColor),
    ),
    bodySmall: TextStyle(fontSize: 14.0, color: Color(Constants.kTextColor)),
    bodyLarge: TextStyle(fontSize: 18.0, color: Color(Constants.kTextColor)),
  );

  static final colorScheme = ColorScheme(
    primary: Color(Constants.kPrimaryColor),
    primaryContainer: Color(Constants.kPrimaryColor).withOpacity(0.8),
    secondary: Color(Constants.kSecondaryColor),
    secondaryContainer: Color(Constants.kSecondaryColor).withOpacity(0.8),
    surface: Colors.white,
    surfaceVariant: Color(Constants.kScaffoldColor),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onSurfaceVariant: Color(Constants.kTextColor),
    onError: Colors.white,
    brightness: Brightness.light,
  );
}
