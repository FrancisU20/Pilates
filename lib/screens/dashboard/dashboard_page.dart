import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pilates/helpers/data/menu_data.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/dashboard_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  Texts texts = Texts();
  final LoadingModal loadingModal = LoadingModal();
  final activities = MenuData.activities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPalette.backgroundColor,
      appBar: const DashboardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: ColorsPalette.backgroundColor,
          padding: EdgeInsets.symmetric(
              horizontal: 5 * SizeConfig.widthMultiplier,
              vertical: 2 * SizeConfig.heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  texts.normalText(
                      text: 'Hola,',
                      color: Colors.grey,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    width: 3 * SizeConfig.widthMultiplier,
                  ),
                  texts.normalText(
                      text: 'Francisco!',
                      color: Colors.black,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 0.5 * SizeConfig.heightMultiplier,
              ),
              Row(
                children: [
                  texts.normalText(
                      text: '¿Qué te gustaría hacer hoy?',
                      color: Colors.grey,
                      fontSize: 2.5 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /* texts.normalText(
                      text: 'Mis Actividades',
                      color: const Color.fromARGB(255, 158, 148, 135),
                      fontSize: 2.5 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start), */
                  SizedBox(
                    height: 2.5 * SizeConfig.heightMultiplier,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 50 * SizeConfig.heightMultiplier,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1600),
                      viewportFraction: 0.8,
                    ),
                    items: activities.map((activitie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(context, activitie['route']!)
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(activitie['image']!),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.darken),
                                ),
                              ),
                              child: Center(
                                child: texts.normalText(
                                    text: activitie['description']!,
                                    color: Colors.white,
                                    fontSize: 2.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 2.5 * SizeConfig.heightMultiplier,
                  ),
                  SizedBox(
                    height: 10 * SizeConfig.heightMultiplier,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        texts.normalText(
                            text: '8 de 10',
                            color: Colors.grey,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: 1.5 * SizeConfig.heightMultiplier,
                        ),
                        SizedBox(
                          width: 70 * SizeConfig.widthMultiplier,
                          child: LinearProgressIndicator(
                            value: 0.8,
                            backgroundColor: Colors.black45,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                ColorsPalette.primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            minHeight: 1 * SizeConfig.heightMultiplier,
                          ),
                        ),
                        SizedBox(
                          height: 0.5 * SizeConfig.heightMultiplier,
                        ),
                        texts.normalText(
                            text: 'Clases Agendadas',
                            color: const Color.fromARGB(255, 158, 148, 135),
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.start),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
