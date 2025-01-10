import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

class AppBirthdayPicker {
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
                  AppColors.brown200, // Color del encabezado
              colorScheme: const ColorScheme.light(
                  primary: AppColors.brown200),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              textTheme: TextTheme(
                // Display texts
                displayLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2.5),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                displayMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                displaySmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.8),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                // Body texts
                bodyLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                bodyMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.8),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                bodySmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                // Headlines text
                headlineLarge: GoogleFonts.montserrat(
                  textStyle:   TextStyle(
                      fontSize:SizeConfig.scaleText(3),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black100),
                ),

                headlineMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2.8),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black100),
                ),

                headlineSmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2.5),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black100),
                ),
                // Labels text
                labelLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2),
                      fontWeight: FontWeight.normal,
                      color: AppColors.black100),
                ),
                labelMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.8),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black100),
                ),
                labelSmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black100),
                ),
                // Title text
                titleLarge: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(2.5),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                titleMedium: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.8),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
                titleSmall: GoogleFonts.montserrat(
                  textStyle:  TextStyle(
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black100),
                ),
              ),
              dialogBackgroundColor: AppColors.black100),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd', 'es').format(selectedDate);
    }
  }
}
