import 'package:flutter/material.dart';

class MyRouter {
  static Route createRoute(Widget route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        // final offsetAnimation = animation.drive(tween);
        // var curveTween = CurveTween(curve: curve);

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
