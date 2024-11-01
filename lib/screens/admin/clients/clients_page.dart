import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/client_classes_controller.dart';
import 'package:pilates/helpers/launchers/maps_launcher.dart';
import 'package:pilates/models/response/all_client_class_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/appbars/bottom_admin_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  ClientsPageState createState() => ClientsPageState();
}

class ClientsPageState extends State<ClientsPage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();
  MapAppLauncher mapAppLauncher = MapAppLauncher();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  //Controlador
  final ClientClassesController clientClassesController =
      ClientClassesController();

  //Variables
  List<AllClientsPlansResponse> clients = [];
  bool activeClients = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getClients();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getClients() async {
    try {
      ClientClassProvider clientClassProvider =
          Provider.of<ClientClassProvider>(context, listen: false);

      // Obtener los clientes desde el provider
      List<AllClientsPlansResponse> allClients =
          clientClassProvider.allClientsPlansResponse ?? [];

      if (activeClients == true) {
        //Filtar los clientes activos
        allClients.where((element) => element.status.contains('active'));
      } else {
        allClients.where((element) => element.status.contains('inactive'));
      }

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      setState(() {
        clients = allClients;
      });
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text: e.toString().replaceAll('Exception: ', ''),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 16,
                    color: Colors.white),
                backgroundColor: const Color.fromARGB(255, 207, 117, 117),
              ),
            ),
          });
    }
  }

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
                      FontAwesomeIcons.user,
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
                          text: 'Clientes',
                          color: Colors.white,
                          fontSize: 4 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                      texts.normalText(
                          text: 'Revisa el estado de tus clientes',
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF262626),
                  borderRadius: BorderRadius.circular(20)),
              width: 90 * SizeConfig.widthMultiplier,
              height: 8 * SizeConfig.heightMultiplier,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttons.iconTextUnderline(
                      icon: FontAwesomeIcons.circleCheck,
                      text: 'Activos',
                      onPressed: () {
                        setState(() {
                          activeClients = true;
                          getClients();
                        });
                      },
                      color: activeClients == false
                          ? Colors.white
                          : const Color.fromARGB(255, 165, 160, 105)),
                  buttons.iconTextUnderline(
                      icon: FontAwesomeIcons.circleXmark,
                      text: 'Inactivos',
                      onPressed: () {
                        setState(() {
                          activeClients = false;
                          getClients();
                        });
                      },
                      color: activeClients == false
                          ? const Color.fromARGB(255, 165, 160, 105)
                          : Colors.white),
                ],
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Flexible(
              child: Container(
                width: 100 * SizeConfig.widthMultiplier,
                height: 58 * SizeConfig.heightMultiplier,
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.widthMultiplier,
                    vertical: 2 * SizeConfig.heightMultiplier),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(
                            50))), //Color.fromARGB(255, 87, 136, 120)
                child: clients.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            activeClients == true
                                ? FontAwesomeIcons.circleCheck
                                : FontAwesomeIcons.circleXmark,
                            size: 20 * SizeConfig.imageSizeMultiplier,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: activeClients == true
                                ? 'No dispones de clientes activos'
                                : 'No dispones de clientes inactivos',
                            color: Colors.black,
                            fontSize: 3 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: clients.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                    text:
                                        '${clients[index].clientName} ${clients[index].clientLastname}',
                                    color: Colors.black,
                                    fontSize: 2.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 4 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                    text: clients[index]
                                        .clientDniNumber
                                        .toString(),
                                    color: const Color.fromARGB(
                                        255, 116, 114, 114),
                                    fontSize: 1.7 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    5 * SizeConfig.widthMultiplier,
                                    2 * SizeConfig.heightMultiplier,
                                    0,
                                    2 * SizeConfig.heightMultiplier),
                                width: 90 * SizeConfig.widthMultiplier,
                                height: 20 * SizeConfig.heightMultiplier,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFEEEEEE),
                                    border: Border.all(
                                        color: const Color(0xFFEEEEEE)),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50 * SizeConfig.widthMultiplier,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          texts.normalText(
                                              text: 'Información',
                                              color: Colors.black,
                                              fontSize: 2.5 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w600),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text:
                                                  'Celular: ${clients[index].clientPhone}',
                                              color: const Color.fromARGB(
                                                  255, 116, 114, 114),
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text: clients[index]
                                                      .paymentMethod
                                                      .contains('bank transfer')
                                                  ? 'Pago: Tranferencia'
                                                  : 'Pago: Efectivo',
                                              color: const Color.fromARGB(
                                                  255, 116, 114, 114),
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text:
                                                  'Plan: ${clients[index].planDescription}',
                                              color: const Color.fromARGB(
                                                  255, 116, 114, 114),
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                    ),
                                    activeClients == true
                                        ? SizedBox(
                                            width:
                                                2 * SizeConfig.widthMultiplier,
                                          )
                                        : const SizedBox.shrink(),
                                    activeClients == true
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                  width: 10 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  height: 10 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF262626),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  padding: EdgeInsets.all(2 *
                                                      SizeConfig
                                                          .widthMultiplier),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .locationArrow,
                                                        color: Colors.white,
                                                        size: 4 *
                                                            SizeConfig
                                                                .imageSizeMultiplier,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2 *
                                                    SizeConfig.heightMultiplier,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: 10 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  height: 10 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              175,
                                                              105,
                                                              105),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  padding: EdgeInsets.all(2 *
                                                      SizeConfig
                                                          .widthMultiplier),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.xmark,
                                                        color: Colors.white,
                                                        size: 4 *
                                                            SizeConfig
                                                                .imageSizeMultiplier,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    // Agregar letras en direccion vertical con el status de la clase
                                    Transform.rotate(
                                      angle: -3.14 / 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              clients[index].status == 'active'
                                                  ? ColorsPalette.successColor
                                                  : const Color.fromARGB(
                                                      255, 175, 105, 105),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                2 * SizeConfig.widthMultiplier,
                                            horizontal:
                                                2 * SizeConfig.widthMultiplier),
                                        child: texts.normalText(
                                          text:
                                              clients[index].status == 'active'
                                                  ? 'Activo'
                                                  : 'Inactivo',
                                          color: Colors.white,
                                          fontSize:
                                              4 * SizeConfig.widthMultiplier,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2 * SizeConfig.heightMultiplier,
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAdminBar(),
    );
  }
}
