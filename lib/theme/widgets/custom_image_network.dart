import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imagePath;
  final double height;
  final double? width;
  final double borderRadius;
  final BoxFit fit;
  final Color errorBackgroundColor;
  final Color errorIconColor;
  final double errorIconSize;

  const CustomImageNetwork({
    super.key,
    required this.imagePath,
    required this.height,
    this.width,
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
      child: Image.network(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          Logger.logAppError('Error loading image: $imagePath - $error');
          return Container(
            height: height,
            width: width,
            color: errorBackgroundColor,
            alignment: Alignment.center,
            child: Icon(
              Icons.broken_image,
              color: errorIconColor,
              size: errorIconSize,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Container(
              height: height,
              width: width,
              color: AppColors.grey200,
              alignment: Alignment.center,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.white100,
                size: SizeConfig.scaleHeight(height / 16),
              ),
            );
          }
        },
      ),
    );
  }
}
