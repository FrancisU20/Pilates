import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';

class ClientIdentification extends StatelessWidget {
  final LoginProvider loginProvider;
  final UserPlanProvider userPlanProvider;

  const ClientIdentification({
    super.key,
    required this.loginProvider,
    required this.userPlanProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleWidth(100),
      height: SizeConfig.scaleHeight(25),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(5),
        vertical: SizeConfig.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageNetwork(
                imagePath: loginProvider.user!.photo,
                height: SizeConfig.scaleHeight(16),
                width: SizeConfig.scaleWidth(22),
              ),
              SizedBox(width: SizeConfig.scaleWidth(5)),
              Column(
                children: [
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageNetwork(
                          imagePath: 'https://curvepilates-bucket.s3.amazonaws.com/app-assets/logo/logo_rectangle_transparent_white.png',
                          height: SizeConfig.scaleHeight(6),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(1)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            '${loginProvider.user!.name} ${loginProvider.user!.lastname}',
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(1.6),
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                      ),
                      CustomText(
                        text: loginProvider.user!.dniNumber,
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(1.6),
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                      ),
                      CustomText(
                        text:
                            'Celular: ${loginProvider.user!.phone.replaceAll('+593', '0')}',
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(1.6),
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                      ),
                      CustomText(
                        text:
                            'Cumpleaños: ${userPlanProvider.convertDate(loginProvider.user!.birthdate.toString().substring(0, 10)).substring(0, 9)}',
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(1.6),
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeConfig.scaleHeight(1.5)),
          Center(
            child: CustomText(
              text:
                  'Miembro desde el ${userPlanProvider.convertDate(loginProvider.user!.createdAt.toString().substring(0, 10))}',
              color: AppColors.white100,
              fontSize: SizeConfig.scaleText(1.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
