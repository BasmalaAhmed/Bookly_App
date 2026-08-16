import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: kFocusedBorderColor,
      secondary: kButtonColor,
      surface: Color(0XFF211035),
      onSurface: Colors.white,
      error: Colors.red,
    ),
    textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: const ColorScheme.light(
      primary: Color(0XFF7C3AED),
      onPrimary: Colors.white,
      secondary: Color(0XFF8B5CF6),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0XFF150526),
      error: Color(0XFFD32F2F),
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.montserratTextTheme(ThemeData.light().textTheme)
        .apply(
          bodyColor: const Color(0XFF150526),
          displayColor: Colors.grey,
        ),
    iconTheme: const IconThemeData(color: Color(0xFF332A48)),
  );
}
