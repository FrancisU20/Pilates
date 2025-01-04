import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

enum SnackBarType { error, success, informative }

class CustomSnackBar {
  /// Método para mostrar el SnackBar
  static void show(BuildContext context, String message, SnackBarType type) {
    final snackBar = SnackBar(
      content: CustomText(
        text: message.replaceAll('Exception: ', ''),
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.start,
        fontSize: SizeConfig.scaleText(2),
        color: AppColors.white100,
        maxLines: 2,
      ),
      backgroundColor: _getBackgroundColor(type),
      duration: const Duration(seconds: 3), // Duración predeterminada
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(2)),
      ),
      margin: EdgeInsets.only(
        left: SizeConfig.scaleWidth(2.5),
        right: SizeConfig.scaleWidth(2.5),
        bottom: SizeConfig.scaleHeight(1),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Determina el color de fondo basado en el tipo de SnackBar
  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.error:
        return AppColors.red300;
      case SnackBarType.success:
        return AppColors.green200;
      case SnackBarType.informative:
        return AppColors.black100;
      default:
        return AppColors.brown300; // Color predeterminado
    }
  }
}
