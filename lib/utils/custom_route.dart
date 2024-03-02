import 'package:flutter/material.dart';

class CustomRoute {
  static Route createRoute({
    required Widget destination,
    required Offset begin,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        // final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          // position: offsetAnimation,
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
