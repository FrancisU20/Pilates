import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/helpers/launchers/instagram_launcher.dart';
import 'package:pilates/helpers/launchers/maps_launcher.dart';
import 'package:pilates/helpers/launchers/whatsapp_launcher.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  ContactUsPageState createState() => ContactUsPageState();
}

class ContactUsPageState extends State<ContactUsPage> {
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();
  Buttons buttons = Buttons();
  MapAppLauncher mapAppLauncher = MapAppLauncher();
  WhatsAppLauncher whatsappLauncher = WhatsAppLauncher();
  InstagramLauncher instagramLauncher = InstagramLauncher();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: ColorsPalette.greyChocolate),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: ColorsPalette.greyChocolate,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.widthMultiplier,
                    vertical: 1 * SizeConfig.heightMultiplier),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 8 * SizeConfig.imageSizeMultiplier,
                      backgroundColor: ColorsPalette.white,
                      child: Icon(
                        FontAwesomeIcons.addressBook,
                        size: 8 * SizeConfig.imageSizeMultiplier,
                        color: ColorsPalette.black,
                      ),
                    ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        texts.normalText(
                            text: 'Contáctanos',
                            color: ColorsPalette.white,
                            fontSize: 4 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400),
                        texts.normalText(
                            text: 'Cerca de ti, para tu comodidad',
                            color: ColorsPalette.white,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.left),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Container(
                  width: 100 * SizeConfig.widthMultiplier,
                  padding: EdgeInsets.symmetric(
                      horizontal: 5 * SizeConfig.widthMultiplier,
                      vertical: 2 * SizeConfig.heightMultiplier),
                  decoration: const BoxDecoration(
                      color: ColorsPalette.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(
                              50))), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            'https://lh3.googleusercontent.com/p/AF1QipMW8J8gtvmHbVCfJhl41InHnxagG7M8O3QLjv3G=s680-w680-h510',
                            width: 50 * SizeConfig.widthMultiplier,
                            height: 50 * SizeConfig.widthMultiplier,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4 * SizeConfig.heightMultiplier,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 22 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'Dirección: \n',
                                color: ColorsPalette.black,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            width: 0.5 * SizeConfig.widthMultiplier,
                          ),
                          SizedBox(
                            width: 63 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text:
                                    'Galo Plaza Lasso 675 y Judith Granda Almeida',
                                color: ColorsPalette.black,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 22 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'Horarios: \n',
                                color: ColorsPalette.black,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            width: 0.5 * SizeConfig.widthMultiplier,
                          ),
                          SizedBox(
                            width: 63 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text:
                                    'Lunes a viernes de 06:00 a 21:00, Sábados de 08:00 a 11:00',
                                color: ColorsPalette.black,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      Center(
                        child: SizedBox(
                          width: 50 * SizeConfig.widthMultiplier,
                          height: 10 * SizeConfig.heightMultiplier,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  double latitude = 0.34291;
                                  double longitude = -78.1352;
                                  String name = 'Curve Pilates';
                                  mapAppLauncher.openMaps(
                                      latitude: latitude,
                                      longitude: longitude,
                                      name: name);
                                },
                                child: Container(
                                  width: 7 * SizeConfig.heightMultiplier,
                                  height: 7 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      color: ColorsPalette.black,
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  padding: EdgeInsets.all(
                                      2 * SizeConfig.widthMultiplier),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.locationArrow,
                                        color: ColorsPalette.white,
                                        size: 7 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  instagramLauncher.instagramRedirect(
                                      username: 'curvepilates_');
                                },
                                child: Container(
                                  width: 7 * SizeConfig.heightMultiplier,
                                  height: 7 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      color: ColorsPalette.black,
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  padding: EdgeInsets.all(
                                      2 * SizeConfig.widthMultiplier),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.instagram,
                                        color: ColorsPalette.white,
                                        size: 7 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  String message =
                                      'Hola Curve Pilates, me gustaría contactarme con ustedes';
                                  await whatsappLauncher.whatsappRedirect(
                                      message: message);
                                },
                                child: Container(
                                  width: 7 * SizeConfig.heightMultiplier,
                                  height: 7 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      color: ColorsPalette.black,
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  padding: EdgeInsets.all(
                                      2 * SizeConfig.widthMultiplier),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: ColorsPalette.white,
                                        size: 7 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                    ],
                                  ),
                                ),
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
      bottomNavigationBar: const BottomBar(),
    );
  }
}
