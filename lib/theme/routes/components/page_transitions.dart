import 'package:flutter/material.dart';

class PageTransitions {
  //? Animación de deslizamiento desde la derecha
  static Widget subpageTransition(Animation<double> animation, Widget child) {
    const begin = Offset(1.0, 0.0); // Comienza fuera de la pantalla por la derecha
    const end = Offset.zero;        // Termina en su posición original
    const curve = Curves.easeInOut; // Curva de animación suave

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  //? Animación de desvanecimiento
  static Widget fadeTransition(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  //? Animación de escala (zoom)
  static Widget scaleTransition(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
