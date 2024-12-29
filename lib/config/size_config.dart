import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static late bool isPortrait;
  static late bool isMobilePortrait;

  static bool _initialized = false;

  /// Inicializa los valores de configuración de tamaño.
  static void init(BoxConstraints constraints, Orientation orientation) {
    if (_initialized) return; // Evitar múltiples inicializaciones
    _initialized = true;

    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      isMobilePortrait = screenWidth < 450;
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  /// Escala el tamaño del texto según la altura.
  static double scaleText(double size) => size * blockHeight;

  /// Escala el tamaño de las imágenes según el ancho.
  static double scaleImage(double size) => size * blockWidth;

  /// Escala el tamaño de cualquier widget según el ancho.
  static double scaleWidth(double size) => size * blockWidth;

  /// Escala el tamaño de cualquier widget según la altura.
  static double scaleHeight(double size) => size * blockHeight;
}
