import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final bool isActive;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.color = AppColors.brown200,
    this.textColor = AppColors.white100,
    this.width = 60,
    this.height = 5,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.scaleWidth(width),
      height: SizeConfig.scaleHeight(height),
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: _buildButtonStyle(),
        child: _buildContent(),
      ),
    );
  }

  /// Construye el estilo del botón basado en su tipo
  ButtonStyle _buildButtonStyle() {
    final baseStyle = ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    return baseStyle.copyWith(
      backgroundColor: WidgetStateProperty.all<Color>(color),
      side: WidgetStateProperty.all(BorderSide.none),
    );
  }

  /// Construye el contenido del botón basado en su tipo
  Widget _buildContent() {
    final hasText = text != null;
    final hasIcon = icon != null;

    if (hasText && hasIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: textColor, size: SizeConfig.scaleHeight(2)),
          SizedBox(width: SizeConfig.scaleWidth(2)),
          CustomText(
            text: text!,
            color: textColor,
            fontSize: SizeConfig.scaleText(2),
            fontWeight: FontWeight.w500,
          ),
        ],
      );
    } else if (hasText) {
      return CustomText(
        text: text!,
        color: textColor,
        fontSize: SizeConfig.scaleText(2),
        fontWeight: FontWeight.w500,
      );
    } else if (hasIcon) {
      return Icon(icon,
          color: textColor, size: SizeConfig.scaleHeight(2));
    }

    throw Exception('El botón debe tener texto o icono');
  }
}
