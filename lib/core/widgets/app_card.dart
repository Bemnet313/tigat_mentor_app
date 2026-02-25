import 'package:flutter/material.dart';
import '../design/tokens.dart';
import '../design/motion.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = color ?? Theme.of(context).cardTheme.color;

    if (onTap == null) {
      return Container(
        margin: margin ?? const EdgeInsets.only(bottom: AppTokens.spacingLg),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          boxShadow: isDark 
              ? [
                  const BoxShadow(
                    color: AppTokens.overlayDark,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ] 
              : AppTokens.elevatedShadow,
          border: isDark 
              ? Border.all(color: AppTokens.primaryOlive.withValues(alpha: 0.2), width: 1.2) 
              : Border.all(color: const Color(0x00000000), width: 0),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppTokens.spacingLg),
          child: child,
        ),
      );
    }

    return AppTapBehavior(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.only(bottom: AppTokens.spacingLg),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          boxShadow: isDark 
              ? [
                  const BoxShadow(
                    color: AppTokens.overlayDark,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ] 
              : AppTokens.elevatedShadow,
          border: isDark 
              ? Border.all(color: AppTokens.primaryOlive.withValues(alpha: 0.2), width: 1.2) 
              : Border.all(color: const Color(0x00000000), width: 0),
        ),
        child: Material(
          color: const Color(0x00000000),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTokens.spacingLg),
            child: child,
          ),
        ),
      ),
    );
  }
}
