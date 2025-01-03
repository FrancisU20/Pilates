import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';

class CustomImageAsset extends StatelessWidget {
  final String imagePath;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final Color errorBackgroundColor;
  final Color errorIconColor;
  final double errorIconSize;

  const CustomImageAsset({
    super.key,
    required this.imagePath,
    required this.height,
    this.borderRadius = 15.0,
    this.fit = BoxFit.cover,
    this.errorBackgroundColor = AppColors.white200,
    this.errorIconColor = AppColors.red300,
    this.errorIconSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imagePath,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            color: errorBackgroundColor,
            alignment: Alignment.center,
            child: Icon(
              Icons.broken_image,
              color: errorIconColor,
              size: errorIconSize,
            ),
          );
        },
      ),
    );
  }
}
