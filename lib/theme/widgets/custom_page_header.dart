import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class CustomPageHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color textColor;

  const CustomPageHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconBackgroundColor = AppColors.white100,
    this.iconColor = AppColors.black100,
    this.textColor = AppColors.black100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(5),
        vertical: SizeConfig.scaleHeight(1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: SizeConfig.scaleImage(8),
            backgroundColor: iconBackgroundColor,
            child: Icon(
              icon,
              size: SizeConfig.scaleImage(7),
              color: iconColor,
            ),
          ),
          SizedBox(
            width: SizeConfig.scaleWidth(5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                color: textColor,
                fontSize:SizeConfig.scaleText(3),
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: subtitle,
                color: textColor,
                fontSize:SizeConfig.scaleText(1.8),
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
