import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  ///colors
    static const Color generalColor = Color.fromRGBO(21, 43, 98, 1);

  
  static const Color light = Color(0xFFF4F7F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF000000);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0xFFBFDBFE);
  static const Color blue300 = Color(0xFF93C5FD);
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color blue800 = Color(0xFF1E40AF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color rose100 = Color(0xFFFFE4E6);
  static const Color rose200 = Color(0xFFFECDD3);
  static const Color rose300 = Color(0xFFFDA4AF);
  static const Color rose400 = Color(0xFFFB7185);
  static const Color rose500 = Color(0xFFF43F5E);
  static const Color rose600 = Color(0xFFE11D48);
  static const Color rose700 = Color(0xFFBE123C);
  static const Color green100 = Color(0xFFF0FDF4);
  static const Color green200 = Color(0xFFCCFBF1);
  static const Color green600 = Color(0xFF0D9488);
  static const Color green700 = Color(0xFF166534);
  static const Color yellow = Color(0xFFFCE000);
  static const Color green = Color(0xFF16A34A);
  static const Color screenBgColor=Color.fromRGBO(243, 244, 245, 0.953);
static const Color screenbgForSpecial=Color.fromRGBO(252, 253, 255, 0.99);
  ///shimmer
  static const Color shimmerBase = Color.fromARGB(255, 207, 207, 207);
  static const Color shimmerHighlight = Color(0xFFFCF9F9);

  /// material colors
  static const MaterialColor blue = MaterialColor(
    0xFF3B82F6,
    <int, Color>{
      50: blue50,
      100: blue100,
      200: blue200,
      300: blue300,
      400: blue400,
      500: blue500,
      600: blue600,
      700: blue700,
      800: blue800,
      900: blue800,
    },
  );

  /// font family
  static const String fontFamily = "Inter";
}
