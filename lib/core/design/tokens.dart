import 'package:flutter/material.dart';

class AppTokens {
  // Colors - Olive Glow Palette
  static const Color primaryOlive = Color(0xFF4A5A23);
  static const Color primaryOliveDark = Color(0xFF0F2B14);
  static const Color accentGlow = Color(0xFFBFF48A);
  static const Color accentNeon = Color(0xFFE6FFBF);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFF7F9F8);
  
  static const Color textPrimary = Color(0xFF1F2E1E);
  static const Color textSecondary = Color(0xFF6E6E6E);
  static const Color textTertiary = Color(0xFFBDBDBD);
  
  static const Color statusRed = Color(0xFFFF4D4D);
  static const Color statusWarning = Color(0xFFFFB800);

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
  static const Duration durationShort = Duration(milliseconds: 180);
  static const Duration durationMedium = Duration(milliseconds: 240);
  static const Duration durationLong = Duration(milliseconds: 360);

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
      color: accentGlow.withValues(alpha: 0.3),
      blurRadius: 32,
      spreadRadius: 8,
      offset: const Offset(0, 8),
    ),
  ];
}
