import 'package:flutter/material.dart';

class AppTokens {
  // Colors - Warm Olive Palette -> New Tigat Branding
  static const Color primaryOlive = Color(0xFF11D462); // Tigat Green
  static const Color primaryOliveDark = Color(0xFF0C9343); // Darker Green
  static const Color accentGlow = Color(0xFFD4AF37); // Premium Gold
  static const Color accentSoft = Color(0xFFF0E6AA); // Soft Gold
  static const Color backgroundLight = Color(0xFFF6F8F7);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF0D1B13); // Light Mode Text
  static const Color textSecondary = Color(0xFF4A5A23); // Placeholder darker text
  static const Color textTertiary = Color(0xFF9AA696);
  
  static const Color statusRed = Color(0xFFFF4D4D);
  static const Color statusWarning = Color(0xFFFFB800);

  // UI Tokens
  static const Color overlayLight = Color(0x0A0D1B13);
  static const Color overlayDark = Color(0x4D0D1B13);
  static const Color borderSubtle = Color(0x1A0D1B13);
  static const Color dividerSoft = Color(0x0D0D1B13);
  static const Color shimmerBase = Color(0xFFEAECE7);
  static const Color shimmerHighlight = Color(0xFFF6F8F3);

  // Spacing (baseline grid of 4px)
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 12.0;
  static const double spacingLg = 16.0;
  static const double spacingXl = 24.0;
  static const double spacingXxl = 32.0;

  // Radii
  static const double radiusSmall = 8.0;
  static const double radiusCard = 20.0;
  static const double radiusLarge = 24.0;
  static const double radiusPill = 50.0;

  // Animations
  static const Duration durationShort = Duration(milliseconds: 120);
  static const Duration durationMedium = Duration(milliseconds: 200);
  static const Duration durationLong = Duration(milliseconds: 220);

  // Shadows
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: primaryOlive.withOpacity(0.08),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primaryOlive.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get glowingShadow => [
    BoxShadow(
      color: accentGlow.withValues(alpha: 0.1),
      blurRadius: 24,
      spreadRadius: 8,
      offset: const Offset(0, 8),
    ),
  ];
}
