import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  // =========================
  // Dark Theme Colors
  // =========================

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    // Main accent color
    primary: Color(0xFFA78BFA),
    onPrimary: Color(0xFF150526),

    // Secondary accent
    secondary: Color(0xFF8B5CF6),
    onSecondary: Color(0xFF150526),

    // Surfaces
    surface: Color(0xFF211035),
    onSurface: Colors.white,

    // Less prominent text/icons
    onSurfaceVariant: Color(0xFFB8A7D9),

    // Borders
    outline: Color(0xFFC4B5FD),
    outlineVariant: Color(0xFF5A476F),

    // Errors
    error: Color(0xFFD32F2F),
    onError: Colors.white,

    // Shadows
    shadow: Color(0xFF707070),
  );

  // =========================
  // Light Theme Colors
  // =========================

  static const ColorScheme lightColorScheme = ColorScheme.light(
    // Main accent color
    primary: Color(0xFF7C3AED),
    onPrimary: Colors.white,

    // Secondary accent
    secondary: Color(0xFF8B5CF6),
    onSecondary: Color(0xFF150526),

    // Surfaces
    surface: Colors.white,
    onSurface: Color(0xFF211035),

    // Less prominent text/icons
    onSurfaceVariant: Color(0xFF6B5A82),

    // Borders
    outline: Color(0xFFC4B5FD),
    outlineVariant: Color(0xFFE5DDF0),

    // Errors
    error: Color(0xFFD32F2F),
    onError: Colors.white,

    // Shadows
    shadow: Color(0xFF707070),
  );

  // =========================
  // ThemeData
  // =========================

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    // Intentionally transparent because Bookly
    // has its own background.
    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: darkColorScheme,

    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: darkColorScheme.onSurface,
      displayColor: darkColorScheme.onSurface,
    ),

    iconTheme: IconThemeData(
      color: darkColorScheme.onSurface,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    // Intentionally transparent because Bookly
    // has its own background.
    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: lightColorScheme,

    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: lightColorScheme.onSurface,
      displayColor: lightColorScheme.onSurface,
    ),

    iconTheme: IconThemeData(
      color: lightColorScheme.onSurface,
    ),
  );
}