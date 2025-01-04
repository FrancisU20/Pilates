import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
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
    this.iconBackgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.textColor = Colors.white,
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
              size: SizeConfig.scaleImage(8),
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
                fontSize: SizeConfig.scaleText(4),
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: subtitle,
                color: textColor,
                fontSize: SizeConfig.scaleText(2),
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
