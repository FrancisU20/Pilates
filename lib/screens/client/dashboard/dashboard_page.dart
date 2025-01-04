import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/data/menu_data.dart';
import 'package:pilates/models/backup/response/client_plans_response.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/client/client_home_bar.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final menuItems = MenuData.menuItems;
  bool noPlans = true;
  bool isNextToExpire = false;
  ClientPlansResponse? currentClientPlan;

  @override
  void initState() {
    super.initState();
  }

  /* void getPlansByClient() async {
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
  } */

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.white100,
      appBar: const ClientHomeBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: AppColors.white100,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(5),
              vertical: SizeConfig.scaleHeight(0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                      text: 'Hola,',
                      color: AppColors.brown200,
                      fontSize: SizeConfig.scaleHeight(4),
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    width: SizeConfig.scaleWidth(3),
                  ),
                  CustomText(
                      text:
                          '${loginProvider.user!.name}!',
                      color: AppColors.brown200,
                      fontSize: SizeConfig.scaleHeight(4),
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(0.5),
              ),
              Row(
                children: [
                  CustomText(
                      text: '¿Qué te gustaría hacer hoy?',
                      color: AppColors.brown200,
                      fontSize: SizeConfig.scaleHeight(2.5),
                      fontWeight: FontWeight.w500),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.scaleHeight(4),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: SizeConfig.scaleHeight(45),
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1600),
                      viewportFraction: 0.8,
                    ),
                    items: menuItems.map((activitie) {
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
                                      AppColors.black100.withOpacity(0.2),
                                      BlendMode.darken),
                                ),
                              ),
                              child: Center(
                                child: CustomText(
                                    text: activitie['description']!,
                                    color: AppColors.white100,
                                    fontSize: SizeConfig.scaleHeight(2.5),
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  noPlans == true
                      ? Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.scaleHeight(5),
                            ),
                            GestureDetector(
                                onTap: () =>
                                    {Navigator.pushNamed(context, '/plans')},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        text: 'Adquiere un plan',
                                        color: AppColors.red300,
                                        fontSize:
                                            SizeConfig.scaleHeight(2.5),
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      width: SizeConfig.scaleWidth(1.5),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.arrowUpRightFromSquare,
                                      color: AppColors.red300,
                                      size: SizeConfig.scaleHeight(2),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: SizeConfig.scaleHeight(2.5),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: SizeConfig.scaleHeight(15),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text:
                                      '${currentClientPlan!.numberOfClasses - currentClientPlan!.attendedClasses} de ${currentClientPlan!.numberOfClasses}',
                                  color: AppColors.brown200,
                                  fontSize: SizeConfig.scaleHeight(2),
                                  fontWeight: FontWeight.w500),
                              SizedBox(
                                height: SizeConfig.scaleHeight(1.5),
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(70),
                                child: LinearProgressIndicator(
                                  value: 0,
                                  backgroundColor: AppColors.brown200,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          AppColors.beige100,),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  minHeight: SizeConfig.scaleHeight(1),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(0.5),
                              ),
                              CustomText(
                                  text: 'Clases Disponibles',
                                  color:
                                      AppColors.brown200,
                                  fontSize: SizeConfig.scaleHeight(2),
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ClientNavBar(),
    );
  }
}
