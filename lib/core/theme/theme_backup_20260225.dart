import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryStatusGreen = Color(0xFF00A859);
  static const Color electricEmerald = Color(0xFF00E676);
  static const Color midnightEmerald = Color(0xFF064439);
  static const Color darkMidnightEmerald = Color(0xFF022C22);
  
  static const Color backgroundLight = Color(0xFFF9FAFB); // Warm Off-White
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFEEEEEE);
  static const Color surfaceLight = Color(0xFFF0F0F0);
  
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFFBDBDBD);
  
  static const Color statusRed = Color(0xFFFF4D4D);
  static const Color statusWarning = Color(0xFFFFB800);

  // Spacing 
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // BorderRadius
  static const double radiusCard = 16.0;
  static const double radiusButton = 12.0;
  static const double radiusInput = 8.0;

  // Layered Shadows
  static List<BoxShadow> get layeredShadow => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.1),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 15), // Gives the 15px soft shadow depth
    ),
  ];

  static ThemeData get lightTheme {
    // Base TextTheme with Noto Sans and 0.3px letter spacing
    final baseTextTheme = GoogleFonts.notoSansTextTheme().apply(
      bodyColor: textPrimary,
      displayColor: textPrimary,
    ).copyWith(
      titleLarge: GoogleFonts.notoSans(color: textPrimary, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.3),
      titleMedium: GoogleFonts.notoSans(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.3),
      bodyMedium: GoogleFonts.notoSans(color: textPrimary, fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.3),
      bodySmall: GoogleFonts.notoSans(color: textSecondary, fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: 0.3),
      headlineMedium: GoogleFonts.notoSans(color: textPrimary, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 0.3),
      labelLarge: GoogleFonts.notoSans(color: textPrimary, fontWeight: FontWeight.bold, letterSpacing: 0.3),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: primaryStatusGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryStatusGreen,
        brightness: Brightness.light,
        surface: surfaceWhite,
        error: statusRed,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.notoSans(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      textTheme: baseTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryStatusGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusButton),
          ),
          padding: const EdgeInsets.symmetric(vertical: spacingMd, horizontal: spacingLg),
          elevation: 0,
        ).copyWith(
          shadowColor: const WidgetStatePropertyAll(surfaceWhite),
        ), // Custom shadows will be applied directly on containers where needed
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0, // Using custom shadows
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const Color darkBackground = Color(0xFF0A1110);
    const Color darkSurface = Color(0xFF13201D);
    const Color darkTextPrimary = Color(0xFFF3F4F6);
    const Color darkTextSecondary = Color(0xFFA1A1AA);

    // Dynamic base TextTheme for dark mode
    final baseTextTheme = GoogleFonts.notoSansTextTheme().apply(
      bodyColor: darkTextPrimary,
      displayColor: darkTextPrimary,
    ).copyWith(
      titleLarge: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.3),
      titleMedium: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.3),
      bodyMedium: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.3),
      bodySmall: GoogleFonts.notoSans(color: darkTextSecondary, fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: 0.3),
      headlineMedium: GoogleFonts.notoSans(color: darkTextPrimary, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 0.3),
      labelLarge: GoogleFonts.notoSans(color: darkTextPrimary, fontWeight: FontWeight.bold, letterSpacing: 0.3),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryStatusGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryStatusGreen,
        brightness: Brightness.dark,
        surface: darkSurface,
        error: statusRed,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.notoSans(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      textTheme: baseTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryStatusGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusButton),
          ),
          padding: const EdgeInsets.symmetric(vertical: spacingMd, horizontal: spacingLg),
          elevation: 0,
        ).copyWith(
          shadowColor: const WidgetStatePropertyAll(darkSurface),
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
      ),
      dividerColor: Colors.white.withValues(alpha: 0.05),
    );
  }
}
