import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/integrations/instagram_launcher.dart';
import 'package:pilates/integrations/maps_launcher.dart';
import 'package:pilates/integrations/whatsapp_launcher.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_icon_button.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.white100,
            appBar: const ClientAppBar(
              backgroundColor: AppColors.brown200,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: Container(
                color: AppColors.brown200,
                child: Column(
                  children: [
                    const CustomPageHeader(
                        icon: FontAwesomeIcons.comment,
                        title: 'Contáctanos',
                        subtitle: 'Cerca de ti, para tu comodidad'),
                    SizedBox(
                      height: SizeConfig.scaleHeight(2),
                    ),
                    Container(
                        width: SizeConfig.scaleWidth(100),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.scaleWidth(5),
                            vertical: SizeConfig.scaleHeight(2)),
                        decoration: const BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.scaleHeight(2),
                            ),
                            Center(
                              child: CustomImageNetwork(
                                  imagePath:
                                      'https://curvepilates-bucket.s3.amazonaws.com/app-assets/banner/banner.jpg',
                                  height: SizeConfig.scaleHeight(20)),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(4),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: SizeConfig.scaleWidth(22),
                                  child: CustomText(
                                      text: 'Dirección: \n',
                                      color: AppColors.black100,
                                      fontSize: SizeConfig.scaleText(1.8),
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.left,
                                      maxLines: 2),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(0.5),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(63),
                                  child: CustomText(
                                      text:
                                          'Galo Plaza Lasso 675 y Judith Granda Almeida',
                                      color: AppColors.black100,
                                      fontSize: SizeConfig.scaleText(1.8),
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.left,
                                      maxLines: 2),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(1),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: SizeConfig.scaleWidth(22),
                                  child: CustomText(
                                      text: 'Horarios: \n \n \n',
                                      color: AppColors.black100,
                                      fontSize: SizeConfig.scaleText(1.8),
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.left,
                                      maxLines: 3),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(0.5),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(63),
                                  child: CustomText(
                                      text:
                                          'Lunes a Viernes - 06:00 a 21:00\nSábados - 08:00 a 11:00\nDomingos Cerrado',
                                      color: AppColors.black100,
                                      fontSize: SizeConfig.scaleText(1.8),
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.left,
                                      maxLines: 4),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(3),
                            ),
                            Center(
                              child: SizedBox(
                                width: SizeConfig.scaleWidth(50),
                                height: SizeConfig.scaleHeight(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomIconButton(
                                      icon: FontAwesomeIcons.locationDot,
                                      onPressed: () {
                                        double latitude = 0.34291;
                                        double longitude = -78.1352;
                                        String name = 'Curve Pilates';
                                        mapServices.openMaps(
                                            latitude: latitude,
                                            longitude: longitude,
                                            name: name);
                                      },
                                      color: AppColors.black100,
                                      height: 7,
                                      iconSize: 3.5,
                                      radius: 100,
                                      isCircle: true,
                                    ),
                                    CustomIconButton(
                                      icon: FontAwesomeIcons.instagram,
                                      onPressed: () {
                                        instagramServices.instagramRedirect(
                                            username: 'curvepilates_');
                                      },
                                      color: AppColors.black100,
                                      height: 7,
                                      iconSize: 3.5,
                                      radius: 100,
                                      isCircle: true,
                                    ),
                                    CustomIconButton(
                                      icon: FontAwesomeIcons.whatsapp,
                                      onPressed: () async {
                                        String message =
                                            'Hola Curve Pilates, me gustaría contactarme con ustedes';
                                        await whatsappServices.whatsappRedirect(
                                            message: message);
                                      },
                                      color: AppColors.black100,
                                      height: 7,
                                      iconSize: 3.5,
                                      radius: 100,
                                      isCircle: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const ClientNavBar(),
          ),
          const AppLoading(),
        ],
      ),
    );
  }
}
