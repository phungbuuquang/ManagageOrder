import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
part 'theme_text.dart';
part 'theme_color.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    final googleFont = GoogleFonts.notoSansTextTheme(AppTextTheme.getTextTheme);

    return ThemeData(
      fontFamily: AppTextTheme.bodyFont,
      primaryColor: AppThemeColor.primary,
      accentColor: AppThemeColor.accent,
      textTheme: googleFont.apply(
        displayColor: AppThemeColor.color252525,
      ),
      accentTextTheme: AppTextTheme.getActionTextTheme,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontFamily: AppTextTheme.titleFont,
          color: Colors.orange,
        ),
      ),
    );
  }
}
