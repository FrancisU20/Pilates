import 'package:flutter/widgets.dart';
import 'package:pilates/common/logger.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockWidth = 0;
  static double blockHeight = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = true;

  /// Inicializa los valores de configuración de tamaño.
  static void init(BoxConstraints constraints, Orientation orientation) {
    if (constraints.maxWidth == 0 || constraints.maxHeight == 0) return; //! Evita que se inicialice en cero si no hay valores, lo cual ayuda en release mode por su capacidad de verificar rapido todo el código. 

    // Siempre inicializa para evitar problemas en modo release
    screenWidth = (orientation == Orientation.portrait)
        ? constraints.maxWidth
        : constraints.maxHeight;
    screenHeight = (orientation == Orientation.portrait)
        ? constraints.maxHeight
        : constraints.maxWidth;

    isPortrait = orientation == Orientation.portrait;
    isMobilePortrait = screenWidth < 450;

    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  /// Escala el tamaño del texto según la altura.
  static double scaleText(double size) {
    _ensureInitialized();
    return size * blockHeight;
  }

  /// Escala el tamaño de las imágenes según el ancho.
  static double scaleImage(double size) {
    _ensureInitialized();
    return size * blockWidth;
  }

  /// Escala el tamaño de cualquier widget según el ancho.
  static double scaleWidth(double size) {
    _ensureInitialized();
    return size * blockWidth;
  }

  /// Escala el tamaño de cualquier widget según la altura.
  static double scaleHeight(double size) {
    _ensureInitialized();
    return size * blockHeight;
  }

  /// Verifica que la configuración esté inicializada antes de escalar
  static void _ensureInitialized() {
    if (blockWidth == 0 || blockHeight == 0) {
      Logger.logAppError("SizeConfig no ha sido inicializado. Llama a SizeConfig.init() antes de usar.");
    }
  }
}
