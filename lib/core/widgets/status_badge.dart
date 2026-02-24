import 'package:flutter/material.dart';
import '../../core/design/tokens.dart';

enum BadgeType { positive, warning, negative, neutral }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeType type;
  final bool isSolid;

  const StatusBadge({
    super.key,
    required this.label,
    this.type = BadgeType.neutral,
    this.isSolid = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color getStatusColor() {
      switch (type) {
        case BadgeType.positive:
          return AppTokens.primaryOlive;
        case BadgeType.warning:
          return AppTokens.statusWarning;
        case BadgeType.negative:
          return AppTokens.statusRed;
        case BadgeType.neutral:
          return isDark ? AppTokens.textSecondary : AppTokens.textSecondary;
      }
    }

    final color = getStatusColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.spacingMd, 
        vertical: AppTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: isSolid ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSolid ? Colors.white : color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
