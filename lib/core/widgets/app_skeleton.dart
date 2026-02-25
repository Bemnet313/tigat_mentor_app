import 'package:flutter/material.dart';
import '../design/tokens.dart';

class AppSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  const AppSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppTokens.radiusSmall,
    this.margin = EdgeInsets.zero,
  });

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            color: Color.lerp(
              Theme.of(context).brightness == Brightness.dark ? AppTokens.surfaceElevated : AppTokens.shimmerBase,
              Theme.of(context).brightness == Brightness.dark ? AppTokens.primaryOliveDark : AppTokens.shimmerHighlight,
              _controller.value,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        );
      },
    );
  }
}
