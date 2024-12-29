import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

class BirthdayPicker {
  static Future<void> selectBirthday(
      BuildContext context, TextEditingController controller) async {
    initializeDateFormatting('es', null);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('es', 'ES'),
      cancelText: 'Cancelar',
      confirmText: 'Seleccionar',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor:
                  ColorsPalette.chocolate, // Color del encabezado
              colorScheme: const ColorScheme.light(
                  primary: ColorsPalette.chocolate),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              textTheme: TextTheme(
                // Display texts
                displayLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2.5 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                displayMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                displaySmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.8 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                // Body texts
                bodyLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                bodyMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.8 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                bodySmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.6 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                // Headlines text
                headlineLarge: GoogleFonts.montserrat(
                  textStyle:   TextStyle(
                      fontSize: 3 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      color: ColorsPalette.black),
                ),

                headlineMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2.8 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      color: ColorsPalette.black),
                ),

                headlineSmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2.5 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      color: ColorsPalette.black),
                ),
                // Labels text
                labelLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.normal,
                      color: ColorsPalette.black),
                ),
                labelMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.8 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      color: ColorsPalette.black),
                ),
                labelSmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.6 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      color: ColorsPalette.black),
                ),
                // Title text
                titleLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 2.5 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                titleMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.8 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
                titleSmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize: 1.6 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                      color: ColorsPalette.black),
                ),
              ),
              dialogBackgroundColor: ColorsPalette.black),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd', 'es').format(selectedDate);
    }
  }
}
