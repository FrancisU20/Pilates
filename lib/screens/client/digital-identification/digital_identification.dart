import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class DigitalIdentificationPage extends StatefulWidget {
  const DigitalIdentificationPage({super.key});

  @override
  DigitalIdentificationPageState createState() =>
      DigitalIdentificationPageState();
}

class DigitalIdentificationPageState extends State<DigitalIdentificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: const ClientAppBar(backgroundColor: AppColors.white100),
          body: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.scaleHeight(20),
            ),
            child: Center(
              child: Transform.rotate(
                angle: 90 * (3.14159265359 / 180), // Rotar 90 grados
                child: FractionallySizedBox(
                  widthFactor: 1.4,
                  heightFactor: 0.6,
                  alignment: Alignment.centerRight,
                  child: Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                      return Consumer<UserPlanProvider>(
                        builder: (context, userPlanProvider, child) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.scaleWidth(10),
                              vertical: SizeConfig.scaleHeight(5),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.black200,
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
                                      height: SizeConfig.scaleHeight(25),
                                      width: SizeConfig.scaleWidth(35),
                                    ),
                                    SizedBox(width: SizeConfig.scaleWidth(5)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: CustomImageNetwork(
                                            imagePath:
                                                'https://curvepilates-bucket.s3.amazonaws.com/app-assets/logo/logo_rectangle_transparent_white.png',
                                            height: SizeConfig.scaleHeight(10),
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.scaleHeight(1)),
                                        CustomText(
                                          text:
                                              '${loginProvider.user!.name} ${loginProvider.user!.lastname}',
                                          color: AppColors.white100,
                                          fontSize: SizeConfig.scaleText(2),
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.left,
                                        ),
                                        CustomText(
                                          text: loginProvider.user!.dniNumber,
                                          color: AppColors.white100,
                                          fontSize: SizeConfig.scaleText(2),
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.left,
                                        ),
                                        CustomText(
                                          text:
                                              'Celular: ${loginProvider.user!.phone.replaceAll('+593', '0')}',
                                          color: AppColors.white100,
                                          fontSize: SizeConfig.scaleText(2),
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.left,
                                        ),
                                        CustomText(
                                          text:
                                              'Cumpleaños: ${userPlanProvider.convertDate(loginProvider.user!.birthdate.toString().substring(0, 10)).substring(0, 9)}',
                                          color: AppColors.white100,
                                          fontSize: SizeConfig.scaleText(2),
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.left,
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
                                    fontSize: SizeConfig.scaleText(2),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        const AppLoading(),
      ],
    );
  }
}
