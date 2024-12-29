import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

enum ButtonStyleType {
  filledText,
  filledTextIcon,
  outlinedIcon,
  outlinedTextIcon,
  outlinedText,
}

class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final bool isActive;
  final ButtonStyleType buttonStyle;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.color = AppColors.white100,
    this.width = 60,
    this.height = 5,
    this.isActive = true,
    this.buttonStyle = ButtonStyleType.filledText,
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

    if (buttonStyle == ButtonStyleType.filledText ||
        buttonStyle == ButtonStyleType.filledTextIcon) {
      return baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.all<Color>(color),
        side: WidgetStateProperty.all(BorderSide.none),
      );
    } else if (buttonStyle == ButtonStyleType.outlinedText ||
               buttonStyle == ButtonStyleType.outlinedTextIcon ||
               buttonStyle == ButtonStyleType.outlinedIcon) {
      return baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        side: WidgetStateProperty.all(
          BorderSide(color: color, width: 1.5),
        ),
      );
    }

    throw Exception('Unsupported button style');
  }

  /// Construye el contenido del botón basado en su tipo
  Widget _buildContent() {
    final hasText = text != null;
    final hasIcon = icon != null;

    if (buttonStyle == ButtonStyleType.outlinedText && hasText) {
      return CustomText(
        text: text!,
        color: color,
        fontSize: SizeConfig.scaleText(2),
      );
    } else if (hasText && hasIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _getContentColor(), size: SizeConfig.scaleHeight(2)),
          SizedBox(width: SizeConfig.scaleWidth(2)),
          CustomText(
            text: text!,
            color: _getContentColor(),
            fontSize: SizeConfig.scaleText(2),
          ),
        ],
      );
    } else if (hasText) {
      return CustomText(
        text: text!,
        color: _getContentColor(),
        fontSize: SizeConfig.scaleText(2),
      );
    } else if (hasIcon) {
      return Icon(icon, color: _getContentColor(), size: SizeConfig.scaleHeight(2));
    }

    throw Exception('CustomButton requires at least text or icon.');
  }

  /// Devuelve el color del contenido basado en el estado y el tipo del botón
  Color _getContentColor() {
    if (buttonStyle == ButtonStyleType.filledText ||
        buttonStyle == ButtonStyleType.filledTextIcon) {
      return AppColors.white100;
    } else {
      return color;
    }
  }
}
