import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xFF343541);
Color activeColor = const Color(0xFF40414f);

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: GoogleFonts.roboto().fontFamily,
  cardColor: const Color(0xFFf7f7f8),
  inputDecorationTheme: const InputDecorationTheme(fillColor: Colors.white),
  iconTheme: IconThemeData(color: primaryColor),
  shadowColor: Colors.grey.withOpacity(0.5),
  textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: const Color(0xff343541)),
      displayMedium: GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: const Color(0xff343541)),
      displaySmall: GoogleFonts.roboto(
        fontSize: 18,
        color: const Color(0xff343541),
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xff343541)),
      bodyMedium: GoogleFonts.roboto(
        color: const Color(0xff343541),
        fontSize: 10,
        fontWeight: FontWeight.w400,
      )),
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xff343541),
  scaffoldBackgroundColor: const Color(0xff343541),
  fontFamily: GoogleFonts.roboto().fontFamily,
  cardColor: const Color(0xFF3e3f4b),
  inputDecorationTheme:
      const InputDecorationTheme(fillColor: Color(0xFF3e3f4b)),
  iconTheme: const IconThemeData(color: Colors.white),
  shadowColor: Colors.black54.withOpacity(0.3),
  textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
          fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
      displaySmall: GoogleFonts.roboto(
        fontSize: 18,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      bodyMedium: GoogleFonts.roboto(
        color: Colors.white54,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      )),
);
