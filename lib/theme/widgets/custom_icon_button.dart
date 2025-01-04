import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class CustomIconButton extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final IconData icon;
  final double? iconSize;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final bool isActive;

  const CustomIconButton({
    super.key,
    this.text,
    this.fontSize = 2,
    required this.icon,
    this.iconSize = 2,
    required this.onPressed,
    this.color = AppColors.brown200,
    this.textColor = AppColors.white100,
    this.width = 30,
    this.height = 15,
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

    if (hasText) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: SizeConfig.scaleHeight(iconSize!)),
          CustomText(
            text: text!,
            color: textColor,
            fontSize: SizeConfig.scaleText(fontSize!),
            fontWeight: FontWeight.w500,
            maxLines: 2,
          ),
        ],
      );
    } else {
      return Icon(icon,
          color: textColor, size: SizeConfig.scaleHeight(iconSize!));
    }
  }
}
