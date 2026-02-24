import 'package:flutter/material.dart';
import '../../core/design/tokens.dart';
import 'interactive_scale.dart';

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
          boxShadow: isDark ? [] : AppTokens.elevatedShadow,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppTokens.spacingLg),
          child: child,
        ),
      );
    }

    return InteractiveScale(
      onTap: onTap,
      scaleDownTo: 0.98,
      child: Container(
        margin: margin ?? const EdgeInsets.only(bottom: AppTokens.spacingLg),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          boxShadow: isDark ? [] : AppTokens.elevatedShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTokens.spacingLg),
            child: child,
          ),
        ),
      ),
    );
  }
}
