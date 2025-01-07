import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/data/activities_data.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/screens/client/user-class/widgets/activities_gallery.dart';
import 'package:pilates/screens/client/user-class/widgets/class_picker.dart';
import 'package:pilates/screens/client/user-class/widgets/hour_picker.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  ClassPageState createState() => ClassPageState();
}

class ClassPageState extends State<ClassPage> {
  CalendarFormat calendarFormat = CalendarFormat.week;
  List<Map<String, String>> activitiesData = ActivitiesData.activities;

  //Variables
  bool isMonth = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ClassProvider userPlanProvider =
          Provider.of<ClassProvider>(context, listen: false);
      //! Limpiar los datos
      userPlanProvider.clearData();

      //? Consulta al de la lista de clases
      await userPlanProvider.getClassList(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: const ClientAppBar(backgroundColor: AppColors.brown200),
          body: Container(
            color: AppColors.brown200,
            child: Column(
              children: [
                const CustomPageHeader(
                    icon: FontAwesomeIcons.calendarPlus,
                    title: 'Agendar Cita',
                    subtitle: 'Selecciona la fecha y hora'),
                SizedBox(
                  height: SizeConfig.scaleHeight(2),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(5),
                        vertical: SizeConfig.scaleHeight(2)),
                    decoration: const BoxDecoration(
                      color: AppColors.white100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    height: SizeConfig.scaleHeight(100),
                    width: SizeConfig.scaleWidth(100),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Ajusta el tamaño del Row al contenido
                              children: [
                                CustomText(
                                  text: 'Ver mes',
                                  fontSize: SizeConfig.scaleText(2),
                                ),
                                // Espacio entre el texto y el icono
                                IconButton(
                                  icon: Icon(
                                      calendarFormat == CalendarFormat.week
                                          ? FontAwesomeIcons.toggleOff
                                          : FontAwesomeIcons.toggleOn),
                                  color: AppColors.black100,
                                  onPressed: () {
                                    setState(() {
                                      calendarFormat =
                                          calendarFormat == CalendarFormat.week
                                              ? CalendarFormat.month
                                              : CalendarFormat.week;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Consumer<ClassProvider>(
                          builder: (context, classProvider, child) {
                            if (classProvider.listClass.isEmpty) {
                              return AppEmptyData(
                                  imagePath: '',
                                  message:
                                      'Es probable que no haya horarios disponibles. Por favor intenta más tarde',
                                  buttonText: 'Volver',
                                  onButtonPressed: () {});
                            } else {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.scaleWidth(2.5),
                                ),
                                width: SizeConfig.scaleWidth(90),
                                height: SizeConfig.scaleHeight(100),
                                child: Column(
                                  children: [
                                    ClassPicker(
                                      calendarFormat: calendarFormat,
                                      classList:
                                          classProvider.listClass,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(2),
                                    ),
                                    if (classProvider
                                        .listClassFilter.isNotEmpty) ...[
                                      CustomText(
                                          text: 'Selecciona la hora de inicio:',
                                          fontSize: SizeConfig.scaleText(2)),
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(2),
                                      ),
                                      HourPicker(
                                        userClassList: classProvider
                                            .listClassFilter,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(2),
                                      ),
                                      CustomText(
                                          text: 'Nuestras actividades:',
                                          fontSize: SizeConfig.scaleText(2)),
                                      ActivitiesGallery(
                                          activitiesData: activitiesData),
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(2),
                                      ),
                                      CustomButton(
                                        text: 'Continuar',
                                        color: AppColors.brown200,
                                        onPressed: () async {
                                          await classProvider
                                              .createClass(context);
                                        },
                                      ),
                                    ]
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: const ClientNavBar(),
        ),
        Consumer<ClassProvider>(
          builder: (context, classProvider, child) {
            if (classProvider.isLoading) {
              return const AppLoading();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
