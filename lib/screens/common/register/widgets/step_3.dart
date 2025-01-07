import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class Step3 extends StatelessWidget {
  const Step3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) {
      return SizedBox(
        height: SizeConfig.scaleHeight(35),
        child: Column(
          children: [
            CircleAvatar(
              radius: SizeConfig.scaleImage(25),
              backgroundColor: AppColors.grey100,
              child: registerProvider.profilePhotoUrl.isNotEmpty
                  ? CustomImageNetwork(imagePath: registerProvider.profilePhotoUrl, height: SizeConfig.scaleImage(50), width: SizeConfig.scaleImage(50), borderRadius: 100,)
                  : Icon(
                      FontAwesomeIcons.cameraRetro,
                      size: SizeConfig.scaleHeight(10),
                      color: AppColors.white100,
                    ),
            ),
            CustomTextButton(
              text: 'Subir una foto',
              onPressed: () {
                AppDialogs.showProfilePhotoPicker(context);
              },
              color: AppColors.brown200,
            ),
          ],
        ),
      );
    });
  }
}
