import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  static TextTheme appTextTheme(AppColorScheme colors) {
    return TextTheme(
      // App Title / Hero Heading / Chapter Title / Profile Name
      displayLarge: GoogleFonts.cormorantGaramond(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: colors.foreground,
      ),
      displayMedium: GoogleFonts.cormorantGaramond(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: colors.foreground,
      ),
      displaySmall: GoogleFonts.cormorantGaramond(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.cardForeground,
      ),

      // Kanji Large (96sp)
      headlineLarge: GoogleFonts.notoSerifJp(
        fontSize: 96,
        fontWeight: FontWeight.w600,
        color: colors.cardForeground,
      ),
      // Example JP (24sp)
      headlineMedium: GoogleFonts.notoSerifJp(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: colors.cardForeground,
      ),

      // Title & Labels
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colors.foreground,
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.2, // ~0.2em
        color: colors.accent,
      ),

      // Body text
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.foreground,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: colors.mutedForeground,
      ),

      // Japanese Reading / Furigana
      labelLarge: GoogleFonts.zenMaruGothic(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 5.4, // 0.3em
        color: colors.mutedForeground,
      ),
      labelMedium: GoogleFonts.zenMaruGothic(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colors.mutedForeground,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.0,
        color: colors.mutedForeground,
      ),
    );
  }
}
