import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/models/response/pilates_classes_response.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final List<PilatesClassesResponse> pilatesClasses;

  const DatePicker(
      {super.key, required this.calendarFormat, required this.pilatesClasses});

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  late DateTime firstDay;
  late DateTime focusedDay;
  DateTime? selectedDay;
  Texts texts = Texts();

  // Mapa de días disponibles
  late Map<DateTime, bool> availableDays;

  @override
  void initState() {
    super.initState();
    firstDay = DateTime.now();
    focusedDay = firstDay;
    selectedDay = focusedDay;

    availableDays = {};
    getAvailableDays();
  }

  void getAvailableDays() {
    // Inicializamos el mapa de días disponibles
    availableDays = {};

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

    // Actualizamos el estado para reflejar los días disponibles en la interfaz
    setState(() {
      availableDays = availableDays;
    });

    log('availableDays: $availableDays');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // Solo permitir la selección si el día tiene citas disponibles
                  DateTime normalizedSelectedDay = DateTime(
                    selectedDay.year,
                    selectedDay.month,
                    selectedDay.day,
                  );
                  if (availableDays[normalizedSelectedDay] == true) {
                    setState(() {
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;
                    });
                  }
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.black, // Cambia el color según prefieras
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  defaultTextStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  disabledTextStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  weekendTextStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
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
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                  weekendStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
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
                            border: Border.all(color: Colors.green),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
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
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
