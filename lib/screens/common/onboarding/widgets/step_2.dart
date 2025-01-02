import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_image_asset.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  Step2State createState() => Step2State();
}

class Step2State extends State<Step2> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageAsset(
          imagePath: 'assets/images/onboarding/onboarding2.jpg',
          height: SizeConfig.scaleHeight(50),
          borderRadius: 15.0,
          errorBackgroundColor: AppColors.white200,
          errorIconColor: AppColors.red300,
          errorIconSize: SizeConfig.scaleHeight(20),
        ),
        SizedBox(height: SizeConfig.scaleHeight(3)),
        CustomText(
            text:
                'Descubre cómo nuestras rutinas te ayudarán a aumentar tu flexibilidad y fortaleza',
            fontSize: SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w400,
            maxLines: 3,),
      ],
    );
  }
}
