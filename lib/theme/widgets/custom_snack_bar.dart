import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

enum SnackBarType { error, success, informative }

class CustomSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const CustomSnackBar({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: CustomText(
        text: message.replaceAll('Exception: ', ''),
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.start,
        fontSize: SizeConfig.scaleText(2),
        color: AppColors.white100,
      ),
      backgroundColor: _getBackgroundColor(),
    );
  }

  /// Determina el color de fondo basado en el tipo de SnackBar
  Color _getBackgroundColor() {
    switch (type) {
      case SnackBarType.error:
        return AppColors.red300;
      case SnackBarType.success:
        return AppColors.green200;
      case SnackBarType.informative:
        return AppColors.brown200;
      default:
        return AppColors.brown200; // Color predeterminado
    }
  }
}
