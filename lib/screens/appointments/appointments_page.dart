import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/client_classes_controller.dart';
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
          await clientClassesController.getClassesByClient(userId);

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
            Container(
              width: 100 * SizeConfig.widthMultiplier,
              height: 57 * SizeConfig.heightMultiplier,
              padding: EdgeInsets.symmetric(
                  horizontal: 5 * SizeConfig.widthMultiplier,
                  vertical: 2 * SizeConfig.heightMultiplier),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(
                          50))), //Color.fromARGB(255, 87, 136, 120)
              child: Expanded(
                child: ListView.builder(
                  itemCount: clientClasses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5 * SizeConfig.widthMultiplier,
                              vertical: 2 * SizeConfig.heightMultiplier),
                          width: 90 * SizeConfig.widthMultiplier,
                          height: 20 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              color: const Color(0xFF262626),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  texts.normalText(
                                      text: convertDate(
                                          clientClasses[index].date.toString()),
                                      color: Colors.white,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.white,
                                    size: 1.5 * SizeConfig.heightMultiplier,
                                  ),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: 'Cliente:',
                                      color: Colors.white,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.start),
                                  SizedBox(
                                    width: 3 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          '${clientClassProvider.loginResponse!.client.name} ${clientClassProvider.loginResponse!.client.lastname}',
                                      color: Colors.white,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.start),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.white,
                                    size: 1.5 * SizeConfig.heightMultiplier,
                                  ),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: 'Sucursal:',
                                      color: Colors.white,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.start),
                                  SizedBox(
                                    width: 3 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          'Galo Plaza Lasso 675 y Judith Granda Almeida',
                                      color: Colors.white,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.start),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              texts.normalText(
                                  text:
                                      'Hora Inicio: ${clientClasses[index].schedule.startHour.substring(0, 5)}',
                                  color: Colors.white,
                                  fontSize: 1.5 * SizeConfig.heightMultiplier,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              texts.normalText(
                                  text:
                                      'Hora Fin: ${clientClasses[index].schedule.startHour.substring(0, 5)}',
                                  color: Colors.white,
                                  fontSize: 1.5 * SizeConfig.heightMultiplier,
                                  fontWeight: FontWeight.w400),
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
