import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color color;
  final bool isActive;
  final double fontSize;

  const CustomTextButton({
    super.key,
    this.text,
    required this.onPressed,
    this.color = AppColors.brown300,
    this.isActive = true,
    this.fontSize = 1.7,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isActive ? onPressed : null,
      child: CustomText(
        text: text ?? '',
        color: color,
        fontSize: SizeConfig.scaleText(fontSize),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
