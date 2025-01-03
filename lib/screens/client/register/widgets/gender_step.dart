import 'package:flutter/material.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_image_asset.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class GenderStep extends StatefulWidget {
  const GenderStep({
    super.key,
  });

  @override
  GenderStepState createState() => GenderStepState();
}

class GenderStepState extends State<GenderStep> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    registerProvider.setGender('M');
                  },
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.scaleWidth(2)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: registerProvider.gender == 'M'
                            ? AppColors.brown200
                            : AppColors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white100,
                    ),
                    child: Column(
                      children: [
                        CustomImageAsset(
                            imagePath: 'assets/images/male.jpg',
                            height: SizeConfig.scaleHeight(23),
                            fit: BoxFit.contain),
                        CustomText(
                          text: 'Hombre',
                          color: registerProvider.gender == 'M'
                              ? AppColors.brown200
                              : AppColors.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.scaleText(2),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    registerProvider.setGender('F');
                  },
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.scaleWidth(2)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: registerProvider.gender == 'F'
                            ? AppColors.brown200
                            : AppColors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white100,
                    ),
                    child: Column(
                      children: [
                        CustomImageAsset(
                            imagePath: 'assets/images/female.jpg',
                            height: SizeConfig.scaleHeight(23),
                            fit: BoxFit.contain),
                        CustomText(
                            text: 'Mujer',
                            color: registerProvider.gender == 'F'
                                ? AppColors.brown200
                                : AppColors.black100,
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.scaleText(2)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.scaleHeight(2)),
            Center(
              child: GestureDetector(
                onTap: () {
                  registerProvider.setGender('X');
                },
                child: SizedBox(
                  height: SizeConfig.scaleHeight(5),
                  width: SizeConfig.scaleWidth(50),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: registerProvider.gender == 'X'
                            ? AppColors.brown200
                            : AppColors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white100,
                    ),
                    child: Center(
                      child: CustomText(
                          text: 'Prefiero no contestar',
                          color: registerProvider.gender == 'X'
                              ? AppColors.brown200
                              : AppColors.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.scaleText(2)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(2)),
          ],
        );
      },
    );
  }
}
