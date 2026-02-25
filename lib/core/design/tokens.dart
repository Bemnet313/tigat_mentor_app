import 'package:flutter/material.dart';

class AppTokens {
  // Colors - Warm Olive Palette
  static const Color primaryOlive = Color(0xFF4A5A23);
  static const Color primaryOliveDark = Color(0xFF1F2A14);
  static const Color accentGlow = Color(0xFFB7D77A);
  static const Color accentSoft = Color(0xFFE3F2C6);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFF6F8F3);
  
  static const Color textPrimary = Color(0xFF1F2E1E);
  static const Color textSecondary = Color(0xFF6C7563);
  static const Color textTertiary = Color(0xFF9AA696);
  
  static const Color statusRed = Color(0xFFFF4D4D);
  static const Color statusWarning = Color(0xFFFFB800);

  // UI Tokens
  static const Color overlayLight = Color(0x0A1F2A14);
  static const Color overlayDark = Color(0x4D1F2A14);
  static const Color borderSubtle = Color(0x1A6C7563);
  static const Color dividerSoft = Color(0x0D6C7563);
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
  static const double radiusCard = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusPill = 50.0;

  // Animations
  static const Duration durationShort = Duration(milliseconds: 120);
  static const Duration durationMedium = Duration(milliseconds: 200);
  static const Duration durationLong = Duration(milliseconds: 220);

  // Shadows
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: primaryOliveDark.withValues(alpha: 0.03),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primaryOliveDark.withValues(alpha: 0.02),
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
