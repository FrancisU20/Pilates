import 'package:flutter/material.dart';

Future<Object?> customNavigator(
  BuildContext context,
  String routeName, {
  Object? arguments,
  bool clearStack = false, // Indica si se debe limpiar el stack de pantallas
}) {
  return Navigator.of(context).pushAndRemoveUntil(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        // Obtener la ruta generada
        final route = Navigator.of(context).widget.onGenerateRoute!(
          RouteSettings(name: routeName, arguments: arguments),
        );

        // Comprobar si es un MaterialPageRoute
        if (route is MaterialPageRoute) {
          return route.builder(context);
        }

        // Manejo en caso de que no sea compatible
        throw Exception(
            'La ruta generada no es compatible con MaterialPageRoute: $routeName');
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300), // Duración de la animación
    ),
    clearStack ? (route) => false : (route) => true, // Controlar el stack según clearStack
  );
}
