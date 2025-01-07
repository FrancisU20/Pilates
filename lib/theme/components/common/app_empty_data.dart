import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class AppEmptyData extends StatelessWidget {
  final String imagePath;
  final String message;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final IconData buttonIcon;

  const AppEmptyData({
    super.key,
    required this.imagePath,
    required this.message,
    required this.buttonText,
    this.onButtonPressed,
    this.buttonIcon = FontAwesomeIcons.plus,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: SizeConfig.scaleWidth(100),
        height: SizeConfig.scaleHeight(100),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.scaleWidth(5),
          vertical: SizeConfig.scaleHeight(2),
        ),
        decoration: const BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(3),
              ),
              Center(
                child: CustomImageNetwork(
                  imagePath: imagePath,
                  height: SizeConfig.scaleHeight(25),
                  errorIconSize: SizeConfig.scaleImage(20),
                  borderRadius: SizeConfig.scaleHeight(100),
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(2),
              ),
              Center(
                child: CustomText(
                  text: message,
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(2.5),
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(2),
              ),
              if (onButtonPressed != null)
                Center(
                  child: CustomButton(
                    text: buttonText,
                    icon: buttonIcon,
                    onPressed: onButtonPressed ?? () {},
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
