import 'package:flutter/material.dart';
import '../design/tokens.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppTokens.primaryOliveDark.withValues(alpha: 0.3) : AppTokens.textSecondary.withValues(alpha: 0.15),
            offset: const Offset(4, 4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: isDark ? AppTokens.overlayLight : AppTokens.backgroundLight,
            offset: const Offset(-4, -4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0x00000000),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingLg),
        ),
      ),
    );
  }
}
