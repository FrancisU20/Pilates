import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/config/size_config.dart';

class AppLoading extends StatelessWidget {

  const AppLoading({super.key});

  void showAppLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AppLoading();
      },
    );
  }

  void closeAppLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.scaleHeight(25)),
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
                color: AppColors.white100, size: SizeConfig.scaleHeight(7.5)),
          ],
        ),
      ),
    );
  }
}
