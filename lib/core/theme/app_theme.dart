import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design/tokens.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.notoSansTextTheme().apply(
      bodyColor: AppTokens.textPrimary,
      displayColor: AppTokens.textPrimary,
    ).copyWith(
      headlineMedium: GoogleFonts.notoSans(color: AppTokens.textPrimary, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5),
      titleLarge: GoogleFonts.notoSans(color: AppTokens.textPrimary, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.1),
      titleMedium: GoogleFonts.notoSans(color: AppTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.1),
      titleSmall: GoogleFonts.notoSans(color: AppTokens.textPrimary, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.1),
      bodyMedium: GoogleFonts.notoSans(color: AppTokens.textPrimary, fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.notoSans(color: AppTokens.textSecondary, fontSize: 12, fontWeight: FontWeight.normal),
      labelLarge: GoogleFonts.notoSans(color: AppTokens.textPrimary, fontSize: 14, fontWeight: FontWeight.bold),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppTokens.backgroundLight,
      primaryColor: AppTokens.primaryOlive,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTokens.primaryOlive,
        brightness: Brightness.light,
        surface: AppTokens.surfaceElevated,
        surfaceTint: Colors.transparent,
        error: AppTokens.statusRed,
      ),
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppTokens.backgroundLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTokens.textPrimary),
        titleTextStyle: GoogleFonts.notoSans(
          color: AppTokens.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppTokens.surfaceElevated,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTokens.primaryOlive,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          ),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppTokens.primaryOlive,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          ),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppTokens.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.spacingLg, 
          vertical: AppTokens.spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: BorderSide(color: AppTokens.primaryOlive.withValues(alpha: 0.5), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: const BorderSide(color: AppTokens.statusRed, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppTokens.textSecondary, fontSize: 13),
        hintStyle: TextStyle(color: AppTokens.textSecondary.withValues(alpha: 0.8), fontSize: 14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppTokens.backgroundLight,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTokens.primaryOlive);
          }
          return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTokens.textSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppTokens.primaryOlive, size: 24);
          }
          return const IconThemeData(color: AppTokens.textSecondary, size: 24);
        }),
      ),
      dividerColor: AppTokens.textSecondary.withValues(alpha: 0.1),
    );
  }

  static ThemeData get darkTheme {
    const Color darkBackground = Color(0xFF0F1410);
    const Color darkSurface = Color(0xFF161E17);
    const Color darkTextPrimary = Color(0xFFF3F4F6);
    const Color darkTextSecondary = Color(0xFFA1A1AA);

    final baseTextTheme = GoogleFonts.notoSansTextTheme().apply(
      bodyColor: darkTextPrimary,
      displayColor: darkTextPrimary,
    ).copyWith(
      headlineMedium: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5),
      titleLarge: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.1),
      titleMedium: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.1),
      titleSmall: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.1),
      bodyMedium: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.notoSans(color: darkTextSecondary, fontSize: 12, fontWeight: FontWeight.normal),
      labelLarge: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: AppTokens.primaryOlive,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTokens.primaryOlive,
        brightness: Brightness.dark,
        surface: darkSurface,
        surfaceTint: Colors.transparent,
        error: AppTokens.statusRed,
      ),
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.notoSans(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTokens.primaryOlive,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          ),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppTokens.primaryOlive,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          ),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.spacingLg, 
          vertical: AppTokens.spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: BorderSide(color: AppTokens.accentGlow.withValues(alpha: 0.5), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
          borderSide: const BorderSide(color: AppTokens.statusRed, width: 1.5),
        ),
        labelStyle: const TextStyle(color: darkTextSecondary, fontSize: 13),
        hintStyle: TextStyle(color: darkTextSecondary.withValues(alpha: 0.5), fontSize: 14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkBackground,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTokens.accentGlow);
          }
          return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkTextSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppTokens.accentGlow, size: 24);
          }
          return const IconThemeData(color: darkTextSecondary, size: 24);
        }),
      ),
      dividerColor: Colors.white.withValues(alpha: 0.05),
    );
  }
}
