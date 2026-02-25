import 'package:flutter/material.dart';

class AppMotion {
  // Durations
  static const Duration short = Duration(milliseconds: 120);
  static const Duration medium = Duration(milliseconds: 220);
  static const Duration long = Duration(milliseconds: 360);
  
  static const Duration modalDuration = Duration(milliseconds: 200);

  // Curves
  static const Curve standard = Curves.easeInOut;

  // Scales & Offsets
  static const double cardTapScale = 0.97;
  static const double modalEntryScale = 0.95;
  static const double pageTransitionSlideY = 12.0;
}

/// A wrapper widget that applies the standard tap scaling behavior.
class AppTapBehavior extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  
  const AppTapBehavior({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<AppTapBehavior> createState() => _AppTapBehaviorState();
}

class _AppTapBehaviorState extends State<AppTapBehavior> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.short,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: AppMotion.cardTapScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    _controller.forward();
  }

  void _onPointerUp(PointerUpEvent event) {
    _controller.reverse();
    if (widget.onTap != null) widget.onTap!();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
