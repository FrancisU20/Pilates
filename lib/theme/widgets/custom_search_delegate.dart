import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class CustomSearchDelegate<T> extends SearchDelegate<T?> {
  final List<T> data;
  final String Function(T) searchField;
  final void Function(dynamic)? onTap;

  CustomSearchDelegate({
    required this.data,
    required this.searchField,
    required this.onTap,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.brown200, // Color de fondo del AppBar
        iconTheme: const IconThemeData(
          color: AppColors.white100, // Color de los iconos
        ),
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColors.white100, // Color del texto en el AppBar
            fontSize: SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
            height: 0.9,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.brown200, // Fondo del campo de texto
        hintStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColors.white100.withOpacity(0.7), // Placeholder
            fontSize: SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
            height: 0.9,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white100, // Borde cuando está enfocado
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white100
                .withOpacity(0.5), // Borde cuando no está enfocado
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.white100, // Color del cursor
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColors.white100, // Color del texto introducido
            fontSize: SizeConfig.scaleText(2),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
            height: 0.9,
          ),
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filtra los resultados en base al query
    final List<T> results = data
        .where((item) =>
            searchField(item).toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: AppColors.white100,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: CustomText(
              text: searchField(results[index]), // Muestra el texto del modelo
              fontSize: SizeConfig.scaleText(2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              close(context, results[index]);
              //? buscar en la lista de datos y enviar el objeto seleccionado
              onTap?.call(results[index]);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Mostrar sugerencias mientras el usuario escribe
    final List<T> suggestions = data
        .where((item) =>
            searchField(item).toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return Container(
      color: AppColors.white100,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: CustomText(
              text: searchField(suggestions[index]), // Texto del modelo
              fontSize: SizeConfig.scaleText(2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              query = searchField(suggestions[index]);
              close(context, suggestions[index]);
              //? buscar en la lista de datos y enviar el objeto seleccionado
              onTap?.call(suggestions[index]);
            },
          );
        },
      ),
    );
  }
}
