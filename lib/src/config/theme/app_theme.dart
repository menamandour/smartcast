import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData themeData(String fontFamily, bool isDark) {
    final brightness = isDark ? Brightness.dark : Brightness.light;
    final colorScheme = isDark
        ? ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.black,
            error: AppColors.error,
          )
        : ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.white,
            error: AppColors.error,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.background,
      cardColor: isDark ? const Color(0xFF1F2937) : AppColors.white,
      canvasColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
      iconTheme: IconThemeData(color: isDark ? AppColors.white : AppColors.black),
      dividerColor: isDark ? Colors.white24 : Colors.black12,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF111827) : AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      textTheme: TextTheme(
        displayLarge: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        displayMedium: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold),
        displaySmall: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        headlineMedium: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        headlineSmall: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        titleLarge: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600),
        bodyLarge: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyMedium: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        bodySmall: _fontStyle(fontFamily,
            color: isDark ? AppColors.white : AppColors.greyDark,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: _fontStyle(fontFamily,
              fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.greyDark : AppColors.greyLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: _fontStyle(fontFamily, color: AppColors.grey, fontSize: 14),
      ),
      colorScheme: colorScheme,
    );
  }

  static TextStyle _fontStyle(String fontFamily,
      {required Color color,
      required double fontSize,
      FontWeight fontWeight = FontWeight.normal}) {
    switch (fontFamily) {
      case 'Tajawal':
        return GoogleFonts.tajawal(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      default:
        return GoogleFonts.inter(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
    }
  }
}
