import 'package:flutter/material.dart';

class AppTheme {
  static const bg           = Color(0xFFF5F6F7);
  static const white        = Color(0xFFFFFFFF);
  static const card         = Color(0xFFFFFFFF);
  static const border       = Color(0xFFE8E8E8);
  static const green        = Color(0xFF00AA13);
  static const greenDark    = Color(0xFF00880F);
  static const greenLight   = Color(0xFFE6F9E8);
  static const greenBorder  = Color(0xFFB3EDB7);
  static const textPrimary  = Color(0xFF1A1A1A);
  static const textSecondary= Color(0xFF666666);
  static const textMuted    = Color(0xFFAAAAAA);
  static const redSoft      = Color(0xFFE53E3E);
  static const redBg        = Color(0xFFFFF5F5);
  static const redBorder    = Color(0xFFFFBBBB);

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: bg,
    colorScheme: const ColorScheme.light(
      primary: green,
      surface: white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: green,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF8F9FA),
      hintStyle: const TextStyle(color: textMuted, fontSize: 13),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: border, width: 1.5)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: green, width: 1.5)),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)),
    ),
    useMaterial3: true,
  );
}