import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextTheme {
  static TextTheme light = GoogleFonts.poppinsTextTheme(
    const TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ).apply(
    bodyColor: AppColors.textOnPrimary,
    displayColor: AppColors.textOnPrimary,
  );

  static TextTheme dark = GoogleFonts.poppinsTextTheme(
    const TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ).apply(
    bodyColor: AppColors.textOnPrimary,
    displayColor: AppColors.textOnPrimary,
  );
}
