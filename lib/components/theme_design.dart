import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorSeed = ColorScheme.fromSeed(seedColor: Color(0xFFFF7043));

final themeDesign = ThemeData().copyWith(
  colorScheme: kColorSeed,
  appBarTheme: AppBarTheme(
    backgroundColor: kColorSeed.primary,
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 22,
      color: kColorSeed.onPrimary,
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      color: kColorSeed.onSurface,
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: kColorSeed.onSurface,
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      color: kColorSeed.surface,
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      color: kColorSeed.onPrimaryContainer,
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 28,
      color: kColorSeed.onPrimary,
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: kColorSeed.surface,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(kColorSeed.onPrimary)),
  ),
  iconTheme: IconThemeData(
    color: kColorSeed.onSurface,
    size: 48,
  ),
);
