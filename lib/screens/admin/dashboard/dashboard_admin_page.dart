import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pilates/controllers/client_plans_controller.dart';
import 'package:pilates/helpers/data/menu_data.dart';
import 'package:pilates/models/response/available_client_class_response.dart';
import 'package:pilates/models/response/client_plans_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/dashboard_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class DashboardAdminPage extends StatefulWidget {
  const DashboardAdminPage({super.key});

  @override
  DashboardAdminPageState createState() => DashboardAdminPageState();
}

class DashboardAdminPageState extends State<DashboardAdminPage> {
  Texts texts = Texts();
  final LoadingModal loadingModal = LoadingModal();
  final activities = MenuData.activities;
  ClientPlansController clientPlansController = ClientPlansController();
  bool noPlans = true;
  bool isNextToExpire = false;
  ClientPlansResponse? currentClientPlan;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPlansByClient();
    });
  }

  void getPlansByClient() async {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);
    try {
      loadingModal.showLoadingModal(context);

      List<ClientPlansResponse> clientPlansResponse =
          await clientPlansController.getPlansByClient(
              clientClassProvider.loginResponse!.client.id, false);

      // Eliminar todos los planes que se activa en el futuro
      clientPlansResponse.removeWhere(
          (element) => element.planVigency.isAfter(DateTime.now()));

      if (clientPlansResponse.isEmpty) {
        clientClassProvider.clearCurrentPlan();
        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
            });
        setState(() {
          noPlans = true;
        });
        return;
      } else {
        clientClassProvider.setClientPlans(clientPlansResponse);

        DateTime now = DateTime.now();

        //Luego determinamos si el plan ya esta expirado
        final currentPlan = clientPlansResponse
            .firstWhere((element) => element.planExpiration.isAfter(now));

        // Verificamos si el plan tiene clases disponibles
        bool getAvailableClasses = await getAvailableClientClass(
            clientClassProvider.loginResponse!.client.id, currentPlan.planId);

        if (!getAvailableClasses) {
          clientClassProvider.clearCurrentPlan();
          Future.microtask(() => {
                loadingModal.closeLoadingModal(context),
              });
          return;
        }

        clientClassProvider.setCurrentPlan(currentPlan);
        setState(() {
          noPlans = false;
          currentClientPlan = currentPlan;
        });

        log('Plan vigente: ${clientClassProvider.currentPlan!.toJson()}');

        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
            });
      }
    } catch (e) {
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
          });
    }
  }

  Future<bool> getAvailableClientClass(String clientId, String planId) async {
    try {
      AvailableClientClassResponse availableClientClassResponse =
          await clientPlansController.getAvailableClassesByClient(
              clientId, planId);

      int count = availableClientClassResponse.data.availableClasses;

      if (count > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  double calculateProgressClass() {
    if (currentClientPlan!.numberOfClasses == 0) {
      return 0.0;
    }

    return (currentClientPlan!.numberOfClasses -
            currentClientPlan!.attendedClasses) /
        currentClientPlan!.numberOfClasses;
  }

  @override
  Widget build(BuildContext context) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context);
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
                      text:
                          '${clientClassProvider.loginResponse!.client.name}!',
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
                              clientClassProvider.clearSelectedDate(),
                              clientClassProvider.clearSelectedHour(),
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
                ],
              )
            ],
          ),
        ),
      ),
      //bottomNavigationBar: const BottomBar(),
    );
  }
}