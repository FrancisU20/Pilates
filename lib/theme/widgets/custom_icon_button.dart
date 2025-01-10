import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class CustomIconButton extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final IconData icon;
  final Color iconColor;
  final double? iconSize;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double? radius;
  final bool? isCircle;
  final bool isActive;

  const CustomIconButton({
    super.key,
    this.text,
    this.fontSize = 2,
    required this.icon,
    this.iconColor = AppColors.white100,
    this.iconSize = 2,
    required this.onPressed,
    this.color = AppColors.brown200,
    this.textColor = AppColors.white100,
    this.width = 30,
    this.height = 15,
    this.radius = 2,
    this.isCircle = false,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Container(
        width: isCircle!
            ? SizeConfig.scaleHeight(height)
            : SizeConfig.scaleWidth(width),
        height: SizeConfig.scaleHeight(height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(radius!)),
          color: color,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: text != null
                ? [
                    Icon(icon,
                        color: iconColor,
                        size: SizeConfig.scaleHeight(iconSize!)),
                    CustomText(
                      text: text!,
                      color: textColor,
                      fontSize:SizeConfig.scaleText(fontSize!),
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                    )
                  ]
                : [
                    Icon(icon,
                        color: iconColor,
                        size: SizeConfig.scaleHeight(iconSize!)),
                  ]),
      ),
    );
  }
}
