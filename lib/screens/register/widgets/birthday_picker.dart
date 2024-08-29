import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pilates/theme/colors_palette.dart';

class BirthdayPicker {
  static Future<void> selectBirthday(
      BuildContext context, TextEditingController controller) async {
    initializeDateFormatting('es', null);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('es', 'ES'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor:
                  ColorsPalette.secondaryColor, // Color del encabezado
              colorScheme: const ColorScheme.light(
                  primary: ColorsPalette.secondaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              textTheme: TextTheme(
                // Display texts
                displayLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                displayMedium: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                displaySmall: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                // Body texts
                bodyLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                bodyMedium: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                bodySmall: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                // Headlines text
                headlineLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),

                headlineMedium: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),

                headlineSmall: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                // Labels text
                labelLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                labelMedium: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                labelSmall: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                // Title text
                titleLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                titleMedium: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                titleSmall: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              dialogBackgroundColor: Colors.black),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd', 'es').format(selectedDate);
    }
  }
}
