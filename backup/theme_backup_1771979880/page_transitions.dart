import 'package:flutter/material.dart';

class FadeSlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadeSlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 12.0 * (1.0 - curvedAnimation.value)),
          child: Opacity(
            opacity: curvedAnimation.value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
