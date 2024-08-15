import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/controllers/pilates_classes_controller.dart';
import 'package:pilates/helpers/data/morning_schedules_data.dart';
import 'package:pilates/models/response/pilates_classes_response.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/date_picker.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
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
  List<Map<String, String>> morningSchedulesData =
      MorningSchedulesData.morningSchedules;

  List<String> morningHours = MorningSchedulesData.morningSchedules
      .map((schedule) => schedule['time-start']!)
      .toSet()
      .toList();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  //Controlador
  final PilatesClassesController pilatesClassesController =
      PilatesClassesController();

  //Variables
  bool isMonth = false;
  List<PilatesClassesResponse> pilatesClasses = [];

  @override
  void initState() {
    super.initState();
    getSchedules();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getSchedules() async {
    try {
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      // Obtener los datos de las clases de pilates
      List<PilatesClassesResponse> pilatesClassesResponse =
          await pilatesClassesController.getSchedules(true);

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      setState(() {
        pilatesClasses = pilatesClassesResponse;
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
                              pilatesClasses: pilatesClasses)
                          : LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 7.5 * SizeConfig.heightMultiplier),
                    ),
                    Column(
                      children: [
                        texts.normalText(text: 'Selecciona la hora:'),
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
                                itemCount: morningHours.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.all(Radius.zero)),
                                        child: TextButton(
                                          onPressed: () {
                                            // Implementar la lógica para seleccionar la hora
                                          },
                                          child: texts.normalText(
                                            text: morningHours[index],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5 * SizeConfig.widthMultiplier,
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
                            texts.normalText(text: 'Actividades disponibles:'),
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier,
                            ),
                            SizedBox(
                              width: 90 * SizeConfig.widthMultiplier,
                              height: 40 * SizeConfig.heightMultiplier,
                              child: ListView.builder(
                                itemCount:
                                    morningSchedulesData.where((schedule) {
                                  return schedule['id_time_range'] ==
                                      'time-range-1';
                                }).length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: 60 * SizeConfig.widthMultiplier,
                                        height:
                                            40 * SizeConfig.heightMultiplier,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              morningSchedulesData[index]
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
                                                  SizeConfig.heightMultiplier,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 2 *
                                                    SizeConfig.heightMultiplier,
                                                left: 4 *
                                                    SizeConfig.widthMultiplier,
                                                right: 4 *
                                                    SizeConfig.widthMultiplier,
                                                bottom: 1 *
                                                    SizeConfig.heightMultiplier,
                                              ),
                                              width: 50 *
                                                  SizeConfig.widthMultiplier,
                                              height: 9 *
                                                  SizeConfig.heightMultiplier,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  texts.normalText(
                                                      text:
                                                          morningSchedulesData[
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
                                                        FontAwesomeIcons.clock,
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
                                                            '${morningSchedulesData[index]['time-start']} - ${morningSchedulesData[index]['time-end']}',
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
                                        width: 5 * SizeConfig.widthMultiplier,
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
                            // Implementar la lógica para continuar
                          },
                        ),
                      ],
                    )
                  ],
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
