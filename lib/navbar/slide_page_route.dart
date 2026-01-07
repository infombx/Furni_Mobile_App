import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final bool fromLeft; // true = left→right, false = right→left

  SlidePageRoute({required this.page, required this.fromLeft})
    : super(
        transitionDuration: const Duration(milliseconds: 50),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final beginOffset = fromLeft
              ? const Offset(-1.0, 0.0)
              : const Offset(1.0, 0.0);

          final tween = Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOutCubic));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}