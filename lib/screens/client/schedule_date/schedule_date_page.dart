import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/controllers/client_classes_controller.dart';
import 'package:pilates/controllers/client_plans_controller.dart';
import 'package:pilates/controllers/pilates_classes_controller.dart';
import 'package:pilates/helpers/data/morning_schedules_data.dart';
import 'package:pilates/models/response/available_client_class_response.dart';
import 'package:pilates/models/response/create_class_response.dart';
import 'package:pilates/models/response/pilates_classes_response.dart';
import 'package:pilates/models/send/create_class_send.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/screens/client/schedule_date/widgets/date_picker.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleDatePage extends StatefulWidget {
  const ScheduleDatePage({super.key});

  @override
  ScheduleDatePageState createState() => ScheduleDatePageState();
}

class ScheduleDatePageState extends State<ScheduleDatePage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  List<Map<String, String>> activitiesData = ActivitiesData.activities;

  List<String> availableHours = [];

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  //Controlador
  final PilatesClassesController pilatesClassesController =
      PilatesClassesController();

  final ClientClassesController clientClassesController =
      ClientClassesController();

  final ClientPlansController clientPlansController = ClientPlansController();

  //Variables
  bool isMonth = false;
  List<PilatesClassesResponse> pilatesClasses = [];
  int? _selectedHourIndex;

  @override
  void initState() {
    super.initState();
    getSchedules();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  void getSchedules() async {
    try {
      ClientClassProvider clientClassProvider =
          Provider.of<ClientClassProvider>(context, listen: false);
      // Mostrar el modal de carga
      Future.microtask(() => loadingModal.showLoadingModal(context));

      // Obtener las clases disponibles antes de continuar
      bool hasAvailableClasses = await getAvailableClientClass(
          clientClassProvider.loginResponse!.client.id,
          clientClassProvider.currentPlan?.planId ?? '1');

      // Si no hay clases disponibles, cierra el modal y redirige al dashboard
      if (!hasAvailableClasses) {
        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
              Navigator.pushNamedAndRemoveUntil(
                  context, '/dashboard', (route) => false),
            });
        Future.microtask(() => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: texts.normalText(
                    text:
                        'No tienes clases disponibles para agendar. Por favor adquiere un plan de pilates.',
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 207, 117, 117),
                ),
              )
            });

        return; // Detener el flujo aquí
      }

      // Obtener los datos de las clases de pilates
      List<PilatesClassesResponse> pilatesClassesResponse =
          await pilatesClassesController.getSchedules(true);

      // Quitar todas la clases que tengan en availablec 0 clases

      pilatesClassesResponse
          .removeWhere((element) => element.availableClasses == 0);

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      setState(() {
        pilatesClasses = pilatesClassesResponse;
      });

      Future.microtask(() => loadingModal.closeLoadingModal(context));
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => loadingModal.closeLoadingModal(context));
      Future.microtask(() => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                  text: e.toString().replaceAll('Exception: ', ''),
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: 16,
                  color: Colors.white,
                ),
                backgroundColor: const Color.fromARGB(255, 207, 117, 117),
              ),
            )
          });
    }
  }

  void getAvailableHours() {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    DateTime selectedDate = clientClassProvider.selectedDate!;

    availableHours = [];

    for (var pilatesClass in pilatesClasses) {
      if (pilatesClass.date.day == selectedDate.day &&
          pilatesClass.date.month == selectedDate.month &&
          pilatesClass.date.year == selectedDate.year) {
        availableHours.add(pilatesClass.schedule.startHour);
      }
    }

    // Ordenar las horas disponibles
    availableHours.sort();

    log('Horas disponibles: $availableHours');

    setState(() {
      availableHours = availableHours;
    });
  }

  void onHourSelected(String hour) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    clientClassProvider.setSelectedHour(hour);

    log('Hora seleccionada: ${clientClassProvider.selectedHour}');
  }

  void searchScheduleId() {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    DateTime? selectedDate = clientClassProvider.selectedDate;
    String? selectedHour = clientClassProvider.selectedHour;

    if (selectedDate == null || selectedHour == null) {
      Future.microtask(() => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text:
                        'Por favor selecciona una fecha y hora antes de continuar',
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 16,
                    color: Colors.white),
                backgroundColor: const Color.fromARGB(255, 207, 117, 117),
              ),
            ),
          });
      return;
    }

    for (var pilatesClass in pilatesClasses) {
      if (pilatesClass.date.day == selectedDate.day &&
          pilatesClass.date.month == selectedDate.month &&
          pilatesClass.date.year == selectedDate.year &&
          pilatesClass.schedule.startHour == selectedHour) {
        log('Clase encontrada: ${pilatesClass.pilatesClassId}');
        clientClassProvider.setSelectedClass(pilatesClass.pilatesClassId);
        break;
      }
    }

    showSheduleConfirm();
  }

  void showSheduleConfirm() async {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    int startHour =
        int.parse(clientClassProvider.selectedHour!.substring(0, 2));
    int endHour = startHour + 1;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: texts.normalText(
              text: 'Confirmar cita',
              color: Colors.black,
              fontSize: 2.5 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: 100 * SizeConfig.widthMultiplier,
              height: 42 * SizeConfig.heightMultiplier,
              child: Column(
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
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts.normalText(
                            text: 'Nombre:',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: 'Apellido:',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: 'Fecha:',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: 'Hora de inicio:',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: 'Hora de fin:',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: 'Duración:',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5 * SizeConfig.widthMultiplier,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts.normalText(
                            text:
                                clientClassProvider.loginResponse!.client.name,
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: clientClassProvider
                                .loginResponse!.client.lastname,
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text:
                                '${clientClassProvider.selectedDate!.day}/${clientClassProvider.selectedDate!.month}/${clientClassProvider.selectedDate!.year}',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: '$startHour:00 hrs',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: '$endHour:00 hrs',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: '50 min',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
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
                  text: 'Cancelar',
                  color: ColorsPalette.primaryColor,
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
              buttons.standart(
                text: 'Confirmar',
                color: ColorsPalette.primaryColor,
                width: 8 * SizeConfig.widthMultiplier,
                onPressed: () {
                  log('Confirmando cita ...');
                  createClass(clientClassProvider.selectedClass!);
                },
              ),
            ],
          );
        });
  }

  void createClass(String classId) async {
    try {
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      // Crear el objeto de la clase de pilates
      ClientClassProvider clientClassProvider =
          Provider.of<ClientClassProvider>(context, listen: false);

      CreateClassSend createClassObject = CreateClassSend(
        clientId: clientClassProvider.loginResponse!.client.id,
        pilatesClassId: classId,
        date: clientClassProvider.selectedDate!,
      );

      // Crear la clase de pilates
      CreateClassResponse createClassResponse =
          await clientClassesController.postClass(createClassObject);

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      if (createClassResponse.message
          .contains('Pilates class created successfully')) {
        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
              Navigator.pushNamedAndRemoveUntil(
                  context, '/appointments', (route) => false),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  content: texts.normalText(
                      text: 'Cita agendada correctamente',
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      fontSize: 16,
                      color: Colors.white),
                  backgroundColor: ColorsPalette.successColor,
                ),
              ),
            });
      }
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
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

  @override
  Widget build(BuildContext context) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context);
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
                      FontAwesomeIcons.calendar,
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
                          text: 'Agendar Cita',
                          color: Colors.white,
                          fontSize: 4 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                      texts.normalText(
                          text: 'Selecciona la fecha y hora',
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
            Flexible(
              child: Container(
                width: 100 * SizeConfig.widthMultiplier,
                height: 68 * SizeConfig.heightMultiplier,
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
                    children: [
                      SizedBox(
                        height: 4 * SizeConfig.heightMultiplier,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _calendarFormat =
                                      _calendarFormat == CalendarFormat.week
                                          ? CalendarFormat.month
                                          : CalendarFormat.week;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Ajusta el tamaño del Row al contenido
                                children: [
                                  texts.normalText(text: 'Ver mes'),
                                  const SizedBox(
                                      width:
                                          8.0), // Espacio entre el texto y el icono
                                  Icon(
                                    _calendarFormat == CalendarFormat.week
                                        ? FontAwesomeIcons.toggleOff
                                        : FontAwesomeIcons.toggleOn,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 90 * SizeConfig.widthMultiplier,
                        height: _calendarFormat == CalendarFormat.week
                            ? 23 * SizeConfig.heightMultiplier
                            : 50 * SizeConfig.heightMultiplier,
                        child: pilatesClasses.isNotEmpty
                            ? DatePicker(
                                calendarFormat: _calendarFormat,
                                pilatesClasses: pilatesClasses,
                                getAvailableHours: getAvailableHours,
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 20 * SizeConfig.widthMultiplier,
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                              color: Colors.black,
                                              size: 10 *
                                                  SizeConfig.heightMultiplier),
                                    ),
                                    SizedBox(
                                      height: 2 * SizeConfig.heightMultiplier,
                                    ),
                                    SizedBox(
                                      width: 50 * SizeConfig.widthMultiplier,
                                      child: texts.normalText(
                                          text:
                                              'Es probable que no haya horarios disponibles. Por favor intenta más tarde.',
                                          color: Colors.black,
                                          fontSize:
                                              2 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Visibility(
                        visible: availableHours.isNotEmpty,
                        child: Column(
                          children: [
                            texts.normalText(
                                text: 'Selecciona la hora de inicio:'),
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier,
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 4 * SizeConfig.widthMultiplier,
                                    right: 4 * SizeConfig.widthMultiplier,
                                    bottom: 2 * SizeConfig.heightMultiplier,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorsPalette.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 90 * SizeConfig.widthMultiplier,
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: ListView.builder(
                                    itemCount: availableHours.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      bool isSelected =
                                          _selectedHourIndex == index;
                                      return Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: isSelected
                                                        ? ColorsPalette
                                                            .secondaryColor
                                                        : Colors.grey,
                                                    width: isSelected ? 2 : 1,
                                                  ),
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.zero)),
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedHourIndex = index;
                                                });
                                                onHourSelected(
                                                    availableHours[index]);
                                              },
                                              child: texts.normalText(
                                                text: availableHours[index]
                                                    .toString()
                                                    .substring(0, 5),
                                                color: isSelected
                                                    ? ColorsPalette
                                                        .secondaryColor
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                5 * SizeConfig.widthMultiplier,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                // Espacio
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                texts.normalText(text: 'Que vas a hacer?'),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                SizedBox(
                                  width: 90 * SizeConfig.widthMultiplier,
                                  height: 40 * SizeConfig.heightMultiplier,
                                  child: ListView.builder(
                                    itemCount: activitiesData.where((schedule) {
                                      return schedule['id_time_range'] ==
                                          'time-range-1';
                                    }).length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Container(
                                            width:
                                                60 * SizeConfig.widthMultiplier,
                                            height: 40 *
                                                SizeConfig.heightMultiplier,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  activitiesData[index]
                                                      ['image']!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 31 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 2 *
                                                        SizeConfig
                                                            .heightMultiplier,
                                                    left: 4 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    right: 4 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    bottom: 1 *
                                                        SizeConfig
                                                            .heightMultiplier,
                                                  ),
                                                  width: 50 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  height: 9 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      texts.normalText(
                                                          text: activitiesData[
                                                                  index]
                                                              ['description']!,
                                                          color: Colors.black,
                                                          fontSize: 1.9 *
                                                              SizeConfig
                                                                  .heightMultiplier,
                                                          textAlign:
                                                              TextAlign.start),
                                                      SizedBox(
                                                        height: 1 *
                                                            SizeConfig
                                                                .heightMultiplier,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            clientClassProvider
                                                                        .selectedHour ==
                                                                    null
                                                                ? FontAwesomeIcons
                                                                    .faceSmile
                                                                : int.parse(clientClassProvider
                                                                            .selectedHour!
                                                                            .substring(
                                                                                0, 2)) >
                                                                        10
                                                                    ? FontAwesomeIcons
                                                                        .moon
                                                                    : FontAwesomeIcons
                                                                        .sun,
                                                            color: Colors.grey,
                                                            size: 2 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                          ),
                                                          SizedBox(
                                                            width: 1 *
                                                                SizeConfig
                                                                    .widthMultiplier,
                                                          ),
                                                          texts.normalText(
                                                            text:
                                                                'Actividad ${index + 1}',
                                                            color: Colors.grey,
                                                            fontSize: 1.6 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                5 * SizeConfig.widthMultiplier,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier,
                            ),
                            buttons.standart(
                              text: 'Continuar',
                              color: ColorsPalette.primaryColor,
                              onPressed: () {
                                searchScheduleId();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
