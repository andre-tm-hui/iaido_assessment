import 'package:flutter/material.dart';
import 'package:iaido_test/constants/colors.dart';

var themeData = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    primary: accent,
    secondary: accentForeground,
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF0F0F0),
    error: Color(0xFFE0D000),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onError: Color(0xFF000000),
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: accent,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: accentForeground,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFF000000),
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: accent,
    ),
    headlineMedium: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: accent,
    ),
    headlineLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      color: accent,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      overlayColor: MaterialStateProperty.all(
        accentForeground.withOpacity(0.3),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? accent.withOpacity(0.5)
            : accent,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(foreground),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      overlayColor: MaterialStateProperty.all(
        accentForeground.withOpacity(0.3),
      ),
    ),
  ),
);
