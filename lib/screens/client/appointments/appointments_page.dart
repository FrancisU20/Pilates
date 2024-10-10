import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/client_classes_controller.dart';
import 'package:pilates/helpers/launchers/maps_launcher.dart';
import 'package:pilates/models/response/client_class_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  AppointmentsPageState createState() => AppointmentsPageState();
}

class AppointmentsPageState extends State<AppointmentsPage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();
  MapAppLauncher mapAppLauncher = MapAppLauncher();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  //Controlador
  final ClientClassesController clientClassesController =
      ClientClassesController();

  //Variables
  List<ClientClassResponse> clientClasses = [];
  bool isHistory = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getClientClasses();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getClientClasses() async {
    try {
      ClientClassProvider clientClassProvider =
          Provider.of<ClientClassProvider>(context, listen: false);
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      String userId = clientClassProvider.loginResponse!.client.id;

      // Obtener los datos de las clases de pilates
      List<ClientClassResponse> clientClassesResponse =
          await clientClassesController.getClassesByClient(userId, isHistory);

      // Ordenar las clases por fecha desde la mas cercana a la mas lejana
      clientClassesResponse.sort((a, b) => a.date.compareTo(b.date));

      // si isHistory es true quita todas la proximas citas desde la fecha actual que esten en estado agendada
      if (isHistory == true) {
        clientClassesResponse.removeWhere((element) =>
            element.date.isAfter(DateTime.now()) &&
            element.statusClass == 'agendada');
      } else {
        clientClassesResponse
            .removeWhere((element) => element.statusClass == 'cancelada');
      }

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      setState(() {
        clientClasses = clientClassesResponse;
        loadingModal.closeLoadingModal(context);
      });
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
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

  // Funcion para convertir la fecha de la clase a un formato mas legible
  String convertDate(String date) {
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);

    // La fecah debe mostrarse como Miércoles 12 de Mayo de 2021
    String monthName = '';

    switch (month) {
      case '01':
        monthName = 'Enero';
        break;
      case '02':
        monthName = 'Febrero';
        break;
      case '03':
        monthName = 'Marzo';
        break;
      case '04':
        monthName = 'Abril';
        break;
      case '05':
        monthName = 'Mayo';
        break;
      case '06':
        monthName = 'Junio';
        break;
      case '07':
        monthName = 'Julio';
        break;
      case '08':
        monthName = 'Agosto';
        break;
      case '09':
        monthName = 'Septiembre';
        break;
      case '10':
        monthName = 'Octubre';
        break;
      case '11':
        monthName = 'Noviembre';
        break;
      case '12':
        monthName = 'Diciembre';
        break;
    }

    return '$day de $monthName de $year';
  }

  String determinteAMFM(String hour) {
    String initialHour = hour.substring(0, 2);
    int hourInt = int.parse(initialHour);
    if (hourInt < 12) {
      return 'AM';
    } else {
      return 'PM';
    }
  }

  String getStringMonth(DateTime classDate) {
    String month = '';
    switch (classDate.month) {
      case 1:
        month = 'ENE';
        break;
      case 2:
        month = 'FEB';
        break;
      case 3:
        month = 'MAR';
        break;
      case 4:
        month = 'ABR';
        break;
      case 5:
        month = 'MAY';
        break;
      case 6:
        month = 'JUN';
        break;
      case 7:
        month = 'JUL';
        break;
      case 8:
        month = 'AGO';
        break;
      case 9:
        month = 'SEP';
        break;
      case 10:
        month = 'OCT';
        break;
      case 11:
        month = 'NOV';
        break;
      case 12:
        month = 'DIC';
        break;
    }
    return month;
  }

  void cancelClass(String classId) async {
    try {
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      // Cancelar la clase
      await clientClassesController.deleteClass(classId);

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text: 'La cita ha sido cancelada correctamente',
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 16,
                    color: Colors.white),
                backgroundColor: ColorsPalette.successColor,
              ),
            ),
          });
      setState(() {
        getClientClasses();
      });
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
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

  void showDeleteConfirm(String classId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: texts.normalText(
              text: 'Confirmar cancelación',
              color: Colors.black,
              fontSize: 2.5 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: 100 * SizeConfig.widthMultiplier,
              height: 30 * SizeConfig.heightMultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logotipo de Curves
                  Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 20 * SizeConfig.heightMultiplier,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo_rectangle.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 10 * SizeConfig.heightMultiplier,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        texts.normalText(
                          text: 'Estás seguro de cancelar esta cita?',
                          color: Colors.black,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightMultiplier,
                        ),
                        texts.normalText(
                          text:
                              'Nota: Una vez cancelada la cita no podrá ser recuperada',
                          color: Colors.black,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: texts.normalText(
                  text: 'Regresar',
                  color: ColorsPalette.primaryColor,
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
              buttons.standart(
                text: 'Confirmar',
                color: ColorsPalette.primaryColor,
                width: 10 * SizeConfig.widthMultiplier,
                onPressed: () {
                  log('Cancelando cita ...');
                  cancelClass(classId);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);
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
                      FontAwesomeIcons.calendarCheck,
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
                          text: 'Citas Agendadas',
                          color: Colors.white,
                          fontSize: 4 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                      texts.normalText(
                          text: 'Qué tenemos para ti hoy?',
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
                      icon: FontAwesomeIcons.clock,
                      text: 'Próximas Citas',
                      onPressed: () {
                        setState(() {
                          isHistory = false;
                          getClientClasses();
                        });
                      },
                      color: isHistory
                          ? Colors.white
                          : const Color.fromARGB(255, 165, 160, 105)),
                  buttons.iconTextUnderline(
                      icon: FontAwesomeIcons.clockRotateLeft,
                      text: 'Historial de Citas',
                      onPressed: () {
                        setState(() {
                          isHistory = true;
                          getClientClasses();
                        });
                      },
                      color: isHistory
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
                child: clientClasses.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.calendarXmark,
                            size: 20 * SizeConfig.imageSizeMultiplier,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: isHistory == false
                                ? 'No tienes citas agendadas'
                                : 'No tienes citas en tu historial',
                            color: Colors.black,
                            fontSize: 3 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.heightMultiplier,
                          ),
                          isHistory == false
                              ? buttons.standart(
                                  text: 'Agendar Cita',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/schedule_date');
                                  },
                                  color: ColorsPalette.primaryColor)
                              : const SizedBox.shrink(),
                        ],
                      )
                    : ListView.builder(
                        itemCount: clientClasses.length,
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
                                        '${clientClasses[index].schedule.startHour.substring(0, 5)} ${determinteAMFM(
                                      clientClasses[index].schedule.startHour,
                                    )}',
                                    color: Colors.black,
                                    fontSize: 3 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 4 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                    text: '50 min',
                                    color: const Color.fromARGB(
                                        255, 116, 114, 114),
                                    fontSize: 1.8 * SizeConfig.heightMultiplier,
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
                                    Container(
                                      width: 21 * SizeConfig.widthMultiplier,
                                      height: 21 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
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
                                          texts.normalText(
                                              text: clientClasses[index]
                                                  .date
                                                  .day
                                                  .toString(),
                                              color: Colors.black,
                                              fontSize: 4 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w600),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text: getStringMonth(
                                                  clientClasses[index].date),
                                              color: Colors.black,
                                              fontSize: 1.5 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5 * SizeConfig.widthMultiplier,
                                    ),
                                    SizedBox(
                                      width: 33 * SizeConfig.widthMultiplier,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          texts.normalText(
                                              text: 'Datos:',
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
                                                  '${clientClassProvider.loginResponse!.client.name} ${clientClassProvider.loginResponse!.client.lastname}',
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
                                              text: clientClassProvider
                                                          .loginResponse!
                                                          .client
                                                          .gender ==
                                                      'male'
                                                  ? 'Hombre'
                                                  : 'Mujer',
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
                                              text: clientClassProvider
                                                  .loginResponse!
                                                  .client
                                                  .birthdate
                                                  .toString()
                                                  .substring(0, 10),
                                              color: const Color.fromARGB(
                                                  255, 116, 114, 114),
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                    ),
                                    isHistory == false
                                        ? SizedBox(
                                            width:
                                                2 * SizeConfig.widthMultiplier,
                                          )
                                        : const SizedBox.shrink(),
                                    isHistory == false
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
                                                onTap: () {
                                                  showDeleteConfirm(
                                                      clientClasses[index].id);
                                                },
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
                                    isHistory == false
                                        ? const SizedBox.shrink()
                                        : Transform.rotate(
                                            angle: -3.14 / 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: clientClasses[index]
                                                            .statusClass ==
                                                        'agendada'
                                                    ? Colors.amber
                                                    : const Color.fromARGB(
                                                        255, 175, 105, 105),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  horizontal: 2 *
                                                      SizeConfig
                                                          .widthMultiplier),
                                              child: texts.normalText(
                                                text: clientClasses[index]
                                                            .statusClass ==
                                                        'agendada'
                                                    ? 'Terminada'
                                                    : 'Cancelada',
                                                color: Colors.white,
                                                fontSize: 4 *
                                                    SizeConfig.widthMultiplier,
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
      bottomNavigationBar: const BottomBar(),
    );
  }
}
