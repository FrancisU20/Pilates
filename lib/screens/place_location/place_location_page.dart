import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/helpers/launchers/maps_launcher.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class PlaceLocationPage extends StatefulWidget {
  const PlaceLocationPage({super.key});

  @override
  PlaceLocationPageState createState() => PlaceLocationPageState();
}

class PlaceLocationPageState extends State<PlaceLocationPage> {
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();
  Buttons buttons = Buttons();
  MapAppLauncher mapAppLauncher = MapAppLauncher();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: ColorsPalette.primaryColor),
      body: Container(
        color: ColorsPalette.primaryColor,
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
                    backgroundColor: Colors.white,
                    child: Icon(
                      FontAwesomeIcons.mapLocationDot,
                      size: 8 * SizeConfig.imageSizeMultiplier,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5 * SizeConfig.widthMultiplier,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      texts.normalText(
                          text: 'Ubicación',
                          color: Colors.white,
                          fontSize: 4 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                      texts.normalText(
                          text: 'Cerca de ti, para tu comodidad',
                          color: Colors.white,
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
                height: 65.76 * SizeConfig.heightMultiplier,
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.widthMultiplier,
                    vertical: 2 * SizeConfig.heightMultiplier),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(
                            50))), //Color.fromARGB(255, 87, 136, 120)
                child: SingleChildScrollView(
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
                            width: 65 * SizeConfig.widthMultiplier,
                            height: 65 * SizeConfig.widthMultiplier,
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
                            width: 25 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'Dirección: \n',
                                color: Colors.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            width: 1 * SizeConfig.widthMultiplier,
                          ),
                          SizedBox(
                            width: 63 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text:
                                    'Galo Plaza Lasso 675 y Judith Granda Almeida',
                                color: Colors.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
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
                            width: 25 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'Horarios: \n',
                                color: Colors.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            width: 1 * SizeConfig.widthMultiplier,
                          ),
                          SizedBox(
                            width: 63 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'De lunes a domingo de 06:00 a 21:00',
                                color: Colors.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      Center(
                        child: buttons.standart(
                          text: 'Ver en mapa',
                          color: ColorsPalette.primaryColor,
                          onPressed: () {
                            double latitude = 0.34291;
                            double longitude = -78.1352;
                            String name = 'Curve Pilates';
                            mapAppLauncher.openMaps(
                                latitude: latitude,
                                longitude: longitude,
                                name: name);
                          },
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
