import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/client_plans_controller.dart';
import 'package:pilates/models/response/all_client_class_response.dart';
import 'package:pilates/models/response/most_popular_plan_response.dart';
import 'package:pilates/models/response/plans_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/screens/admin/dashboard/widgets/pie_data_widget.dart';
import 'package:pilates/theme/appbars/bottom_admin_bar.dart';
import 'package:pilates/theme/appbars/dashboard_admin_appbar.dart';
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

  //Controladores
  ClientPlansController clientPlansController = ClientPlansController();

  // Variables de estado
  bool emptyPlans = true;
  List<AllClientsPlansResponse>? clientsPlans;

  double totalProfits = 0;
  int totalClients = 0;
  int totalActivePlans = 0;
  int totalInactivePlans = 0;
  PlanInfo? mostPopularPlan;

  String? currentMonth;

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllClientPlans();
      calculateStatistics();
    });
  }

  Future<void> getAllClientPlans() async {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);
    try {
      loadingModal.showLoadingModal(context);

      List<AllClientsPlansResponse> allClientsPlansResponse =
          await clientPlansController.getAllClientsPlans();

      if (allClientsPlansResponse.isEmpty) {
        clientClassProvider.clearAllClientsPlansResponse();
        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
            });
        setState(() {
          emptyPlans = true;
        });
        return;
      } else {
        clientClassProvider.setAllClientsPlansResponse(allClientsPlansResponse);

        // Obtiene el mes actual
        DateTime now = DateTime.now();
        currentMonth = now.month.toString();

        // Cambiar el mes a nombre del mes
        switch (currentMonth) {
          case '1':
            currentMonth = 'Enero';
            break;
          case '2':
            currentMonth = 'Febrero';
            break;
          case '3':
            currentMonth = 'Marzo';
            break;
          case '4':
            currentMonth = 'Abril';
            break;
          case '5':
            currentMonth = 'Mayo';
            break;
          case '6':
            currentMonth = 'Junio';
            break;
          case '7':
            currentMonth = 'Julio';
            break;
          case '8':
            currentMonth = 'Agosto';
            break;
          case '9':
            currentMonth = 'Septiembre';
            break;
          case '10':
            currentMonth = 'Octubre';
            break;
          case '11':
            currentMonth = 'Noviembre';
            break;
          case '12':
            currentMonth = 'Diciembre';
            break;
        }

        setState(() {
          emptyPlans = false;
          clientsPlans = allClientsPlansResponse;
          currentMonth = currentMonth;
        });
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

  void calculateStatistics() async {
    try {
      loadingModal.showLoadingModal(context);
      ClientClassProvider clientClassProvider =
          Provider.of<ClientClassProvider>(context, listen: false);
      List<AllClientsPlansResponse> allClientsPlansResponse =
          clientClassProvider.allClientsPlansResponse!;
      double totalProfits = 0;
      int totalClients = 0;
      int totalActivePlans = 0;
      int totalInactivePlans = 0;
      PlanInfo? mostPopularPlan;
      for (AllClientsPlansResponse clientPlan in allClientsPlansResponse) {
        totalProfits += double.parse(clientPlan.planPrice);
        totalClients += 1;
        if (clientPlan.statusPlan.contains('inactive')) {
          totalInactivePlans += 1;
        } else {
          totalActivePlans += 1;
        }
      }

      MostPopularPlanResponse mostPopularPlanResponse =
          await clientPlansController.getMostPopularPlan();

      String mostPopularPlanId = mostPopularPlanResponse.planId;

      mostPopularPlan =
          await clientPlansController.getPlanById(mostPopularPlanId);

      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
          });

      setState(() {
        this.totalProfits = totalProfits;
        this.totalClients = totalClients;
        this.totalActivePlans = totalActivePlans;
        this.totalInactivePlans = totalInactivePlans;
        this.mostPopularPlan = mostPopularPlan;
      });
    } catch (e) {
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: texts.normalText(
                  text: e.toString().replaceAll('Exception: ', ''),
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: 2 * SizeConfig.widthMultiplier,
                  color: ColorsPalette.white),
              backgroundColor: ColorsPalette.redAged,
            ))
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context);
    return Scaffold(
      backgroundColor: ColorsPalette.white,
      appBar: const DashboardAdminAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: ColorsPalette.white,
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
                      color: ColorsPalette.greyAged,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    width: 3 * SizeConfig.widthMultiplier,
                  ),
                  texts.normalText(
                      text:
                          '${clientClassProvider.loginResponse!.client.name}!',
                      color: ColorsPalette.black,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 0.5 * SizeConfig.heightMultiplier,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 90 * SizeConfig.widthMultiplier,
                    child: texts.normalText(
                        text:
                            'Estas son las métricas de Curve del mes de $currentMonth',
                        color: ColorsPalette.greyAged,
                        fontSize: 2.5 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.justify),
                  ),
                ],
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier,
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await getAllClientPlans();
                        calculateStatistics();
                      },
                      child: Icon(
                        FontAwesomeIcons.arrowRotateLeft,
                        color: ColorsPalette.beigeAged,
                        size: 2 * SizeConfig.heightMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier,
              ),
              Card(
                borderOnForeground: true,
                color: ColorsPalette.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5 * SizeConfig.widthMultiplier,
                      vertical: 2 * SizeConfig.heightMultiplier),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                        width: 90 * SizeConfig.widthMultiplier,
                        child: texts.normalText(
                            text: 'Información de planes ',
                            color: ColorsPalette.greyAged,
                            fontSize: 2.5 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Container(
                                  width: 3 * SizeConfig.widthMultiplier,
                                  height: 3 * SizeConfig.heightMultiplier,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsPalette.beigeAged,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                texts.normalText(
                                    text: 'Activos',
                                    color: ColorsPalette.beigeAged,
                                    fontSize: 2.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Container(
                                  width: 3 * SizeConfig.widthMultiplier,
                                  height: 3 * SizeConfig.heightMultiplier,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsPalette.greyAged,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                texts.normalText(
                                    text: 'Finalizados',
                                    color: ColorsPalette.greyAged,
                                    fontSize: 2.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 90 * SizeConfig.widthMultiplier,
                        height: 15 * SizeConfig.heightMultiplier,
                        child: PieDataWidget(
                          totalActivePlans:
                              totalActivePlans, // Sustituye por tus valores reales
                          totalInactivePlans:
                              totalInactivePlans, // Sustituye por tus valores reales
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              // Crea una tarjeta que muestre las ganancias totales con un gráfico de barras
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    borderOnForeground: true,
                    color: ColorsPalette.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5 * SizeConfig.widthMultiplier,
                          vertical: 2 * SizeConfig.heightMultiplier),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                            width: 35 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'Ganancias totales',
                                color: ColorsPalette.greyAged,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(
                              width: 30 * SizeConfig.widthMultiplier,
                              height: 10 * SizeConfig.heightMultiplier,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  texts.normalText(
                                      text:
                                          '\$ ${totalProfits.toStringAsFixed(2)}',
                                      color: ColorsPalette.greenAged,
                                      fontSize:
                                          2.8 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    borderOnForeground: true,
                    color: ColorsPalette.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5 * SizeConfig.widthMultiplier,
                          vertical: 2 * SizeConfig.heightMultiplier),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                            width: 30 * SizeConfig.widthMultiplier,
                            child: texts.normalText(
                                text: 'Total de clientes',
                                color: ColorsPalette.greyAged,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(
                              width: 30 * SizeConfig.widthMultiplier,
                              height: 10 * SizeConfig.heightMultiplier,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  texts.normalText(
                                      text: totalClients.toString(),
                                      color: ColorsPalette.beigeAged,
                                      fontSize: 8 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              // Crea una tarjeta con la información del plan más popular
              Card(
                borderOnForeground: true,
                color: ColorsPalette.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5 * SizeConfig.widthMultiplier,
                      vertical: 2 * SizeConfig.heightMultiplier),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                        width: 90 * SizeConfig.widthMultiplier,
                        child: texts.normalText(
                            text: 'Plan más popular',
                            color: ColorsPalette.greyAged,
                            fontSize: 2.5 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        width: 70 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorsPalette.beige,
                              ColorsPalette.whiteAlternative,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.5,
                              0.5
                            ], // Marca el punto medio donde los colores cambian
                          ),
                          borderRadius: BorderRadius.circular(
                              2 * SizeConfig.heightMultiplier),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 14 * SizeConfig.heightMultiplier,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 1 * SizeConfig.heightMultiplier,
                                  ),
                                  Center(
                                    child: texts.normalText(
                                      text: mostPopularPlan != null
                                          ? mostPopularPlan!.classesCount
                                              .toString()
                                          : '',
                                      color: ColorsPalette.black,
                                      fontSize: 5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Center(
                                    child: texts.normalText(
                                      text: 'clases',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2 * SizeConfig.heightMultiplier,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10 * SizeConfig.heightMultiplier,
                              child: Column(
                                children: [
                                  texts.normalText(
                                    text: mostPopularPlan != null
                                        ? mostPopularPlan!.name
                                        : '',
                                    color: ColorsPalette.black,
                                    fontSize: 1.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  texts.normalText(
                                    text: mostPopularPlan != null
                                        ? '\$ ${mostPopularPlan?.basePrice}/mes'
                                        : '',
                                    color: ColorsPalette.black,
                                    fontSize: 2.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  texts.normalText(
                                    text: mostPopularPlan != null
                                        ? '\$ ${mostPopularPlan?.pricePerClass}/mes'
                                        : '',
                                    color: ColorsPalette.black,
                                    fontSize: 1.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAdminBar(),
    );
  }
}
