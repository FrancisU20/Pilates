import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/models/response/pilates_classes_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final List<PilatesClassesResponse> pilatesClasses;
  final Function getAvailableHours;

  const DatePicker(
      {super.key,
      required this.calendarFormat,
      required this.pilatesClasses,
      required this.getAvailableHours});

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  late DateTime firstDay;
  late DateTime focusedDay = DateTime.now().add(const Duration(days: 2));
  DateTime? selectedDay;
  Texts texts = Texts();

  // Mapa de días disponibles
  late Map<DateTime, bool> availableDays;

  @override
  void initState() {
    super.initState();
    firstDay = DateTime.now().add(const Duration(days: 2));
    availableDays = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAvailableDays();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getAvailableDays() {
    // Recorremos todas las clases de pilates
    for (var pilatesClass in widget.pilatesClasses) {
      // Normalizamos la fecha de la clase para evitar problemas con componentes de tiempo
      DateTime classDate = DateTime(
        pilatesClass.date.year,
        pilatesClass.date.month,
        pilatesClass.date.day,
      );

      // Si ya hemos determinado que el día tiene clases disponibles, continuamos
      if (availableDays[classDate] == true) {
        continue;
      }

      // Si la clase tiene cupos disponibles, marcamos el día como disponible
      if (pilatesClass.availableClasses > 0) {
        availableDays[classDate] = true;
      } else {
        // Si ninguna clase en este día tiene cupos disponibles, lo marcamos como no disponible
        if (availableDays[classDate] != true) {
          availableDays[classDate] = false;
        }
      }
    }

    DateTime now = DateTime.now().add(const Duration(days: 2));

    // Normalizar la fecha actual con la hora a 00:00:00
    DateTime normalizedNow = DateTime(
      now.year,
      now.month,
      now.day,
    );

    // La condicional debe ser si es mayor o igual a la fecha actual para que siempre comience en el primer día disponible
    DateTime firstAvailableDay = focusedDay = availableDays.entries
        .firstWhere((element) =>
            element.key.isAfter(normalizedNow) ||
            element.key.isAtSameMomentAs(normalizedNow))
        .key;

    //Colocar el firstAvailableDay en el provider
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);
    clientClassProvider.setSelectedDate(firstAvailableDay);

    log('availableDays: $availableDays');
    log('Selected Day Initialized on Provider: ${clientClassProvider.selectedDate}');

    // Actualizamos el estado para reflejar los días disponibles en la interfaz
    setState(() {
      widget.getAvailableHours();
      availableDays = availableDays;
      focusedDay = firstAvailableDay;
      selectedDay = focusedDay;
    });
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);
    // Solo permitir la selección si el día tiene citas disponibles
    DateTime normalizedSelectedDay = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    if (availableDays[normalizedSelectedDay] == true) {
      clientClassProvider.setSelectedDate(normalizedSelectedDay);
      setState(() {
        widget.getAvailableHours();
        this.selectedDay = selectedDay;
        this.focusedDay = focusedDay;
      });
    }

    log('selectedDay: ${clientClassProvider.selectedDate}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPalette.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: TableCalendar(
                firstDay: firstDay,
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                calendarFormat: widget.calendarFormat,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  onDaySelected(selectedDay, focusedDay);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    color: ColorsPalette.beigeAged,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: ColorsPalette.black, // Cambia el color según prefieras
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.white,
                      fontSize: 3 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  defaultTextStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.black,
                      fontSize: 3 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  disabledTextStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.greyAged,
                      fontSize: 3 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  weekendTextStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.black,
                      fontSize: 3 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                daysOfWeekHeight: 5 * SizeConfig.heightMultiplier,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.black,
                      fontSize: 3.2 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.black,
                      fontSize: 3 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  weekendStyle: GoogleFonts.montserrat(
                    textStyle:  TextStyle(
                      color: ColorsPalette.black,
                      fontSize: 3 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                locale: 'es_ES',
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Mes',
                  CalendarFormat.week: 'Semana',
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    DateTime normalizedDay = DateTime(
                      day.year,
                      day.month,
                      day.day,
                    );
                    if (availableDays[normalizedDay] == true) {
                      // Días con citas disponibles (círculo verde sin relleno)
                      return Center(
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorsPalette.greenAged),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: GoogleFonts.montserrat(
                                textStyle:  TextStyle(
                                  color: ColorsPalette.black,
                                  fontSize: 3 * SizeConfig.widthMultiplier,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                  height: 0.9,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Días sin citas (sin estilo especial)
                      return null;
                    }
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    // Día seleccionado con relleno (color negro)
                    return Center(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsPalette.black,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: GoogleFonts.montserrat(
                              textStyle:  TextStyle(
                                color: ColorsPalette.white,
                                fontSize: 3 * SizeConfig.widthMultiplier,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5,
                                height: 0.9,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Aquí puedes agregar otros widgets debajo del calendario
          ],
        ),
      ),
    );
  }
}
