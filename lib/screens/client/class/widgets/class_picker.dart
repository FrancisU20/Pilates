import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/providers/class/class_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ClassPicker extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final List<ClassModel> classList;

  const ClassPicker({
    super.key,
    required this.calendarFormat,
    required this.classList,
  });

  @override
  ClassPickerState createState() => ClassPickerState();
}

class ClassPickerState extends State<ClassPicker> {
  DateTime firstDay = DateTime.now().toLocal();
  DateTime focusedDay =
      DateTime.now().toLocal();
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassProvider>(
      builder: (context, classProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white200,
            borderRadius: BorderRadius.circular(15),
          ),
          width: SizeConfig.scaleWidth(90),
          height: widget.calendarFormat == CalendarFormat.week
              ? SizeConfig.scaleHeight(25)
              : SizeConfig.scaleHeight(55),
          child: TableCalendar(
            firstDay: firstDay,
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay,
            calendarFormat: widget.calendarFormat,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onPageChanged: (focusedDay) {
              classProvider.getClassList(context);
              classProvider.cleanSelectedHourIndex();
              classProvider.cleanListClassFilter();
              setState(() {
                this.focusedDay = focusedDay;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              // Verifica si el día está en la lista de clases
              if (widget.classList.any((element) =>
                  element.classDate ==
                  selectedDay.toString().substring(0, 10))) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay; // Actualiza el día enfocado
                });
                classProvider.cleanSelectedHourIndex();
                classProvider.filterClassByDate(context, selectedDay);
              }
            },
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: AppColors.brown200,
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: AppColors.green200,
                    width: 1,
                  ),
                ),
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.black100, // Cambia el color según prefieras
                shape: BoxShape.circle,
              ),
              defaultDecoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              selectedTextStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.white100,
                  fontSize: SizeConfig.scaleText(1.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  height: 0.9,
                ),
              ),
              defaultTextStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(1.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  height: 0.9,
                ),
              ),
              disabledTextStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.brown200,
                  fontSize: SizeConfig.scaleText(1.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  height: 0.9,
                ),
              ),
              weekendTextStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(1.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  height: 0.9,
                ),
              ),
            ),
            daysOfWeekHeight: SizeConfig.scaleHeight(5),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(2.5),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  height: 0.9,
                ),
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(1.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  height: 0.9,
                ),
              ),
              weekendStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(1.7),
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
              defaultBuilder: (context, date, focusedDay) {
                String normalizedDay = DateTime(
                  date.year,
                  date.month,
                  date.day,
                ).toString().substring(0, 10);

                if (widget.classList
                    .any((element) => element.classDate == normalizedDay)) {
                  return Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.green200),
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: AppColors.black100,
                              fontSize: SizeConfig.scaleText(1.7),
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
              selectedBuilder: (context, date, focusedDay) {
                // Día seleccionado con relleno (color negro)
                return Center(
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.black100,
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: AppColors.white100,
                            fontSize: SizeConfig.scaleText(1.7),
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
        );
      },
    );
  }
}
