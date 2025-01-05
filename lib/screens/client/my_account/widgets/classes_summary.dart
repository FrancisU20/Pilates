import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class ClassesSummary extends StatelessWidget {
  final int classesCount;
  final int remainingClasses;

  const ClassesSummary({
    super.key,
    required this.classesCount,
    required this.remainingClasses,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: SizeConfig.scaleWidth(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildClassInfo(
              context,
              classesCount.toString(),
              'Clases contratadas',
              AppColors.black100,
              AppColors.white100,
            ),
            _buildClassInfo(
              context,
              remainingClasses.toString(),
              'Clases restantes',
              AppColors.beige100,
              AppColors.white100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassInfo(
    BuildContext context,
    String countText,
    String labelText,
    Color backgroundColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Container(
          width: SizeConfig.scaleWidth(15),
          height: SizeConfig.scaleWidth(15),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.all(SizeConfig.scaleWidth(2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: countText,
                color: textColor,
                fontSize: SizeConfig.scaleText(3.5),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(1),
        ),
        CustomText(
          text: labelText,
          color: AppColors.black100,
          fontSize: SizeConfig.scaleHeight(1.5),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
