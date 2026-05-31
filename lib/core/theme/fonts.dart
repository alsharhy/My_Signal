import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppFonts {
  AppFonts._();

  // Use Tajawal from Google Fonts for Arabic-friendly UI
  static final TextTheme textTheme = GoogleFonts.tajawalTextTheme().copyWith(
    displayLarge:
        GoogleFonts.tajawal(fontSize: 34, fontWeight: FontWeight.bold),
    displayMedium:
        GoogleFonts.tajawal(fontSize: 28, fontWeight: FontWeight.w700),
    titleLarge: GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.tajawal(fontSize: 16, color: AppColors.textPrimary),
    bodySmall:
        GoogleFonts.tajawal(fontSize: 14, color: AppColors.textSecondary),
    labelLarge: GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w600),
  );
}
