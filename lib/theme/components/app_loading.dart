import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black100.withOpacity(0.8),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(25)),
              ),
              clipBehavior: Clip.hardEdge,
              height: SizeConfig.scaleHeight(25),
              child: Image.asset(
                imagesPaths.logoSquareFill,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(5)),
            LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.white100,
              size: SizeConfig.scaleHeight(7.5),
            ),
          ],
        ),
      ),
    );
  }
}