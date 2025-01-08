import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/data/activities_data.dart';
import 'package:pilates/providers/class/class_provider.dart';
import 'package:pilates/screens/client/class/widgets/activities_gallery.dart';
import 'package:pilates/screens/client/class/widgets/class_picker.dart';
import 'package:pilates/screens/client/class/widgets/hour_picker.dart';
import 'package:pilates/screens/client/class/widgets/view_month.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
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
      //? Limpiar clase seleccionada e index
      userPlanProvider.cleanSelectedHourIndex();
      userPlanProvider.cleanSelectedClass();

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
          appBar: const ClientAppBar(
              backgroundColor: AppColors.brown200, ),
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
                Consumer<ClassProvider>(
                  builder: (context, classProvider, child) {
                    if (classProvider.listClass.isEmpty) {
                      return AppEmptyData(
                          imagePath:
                              'https://curvepilates-bucket.s3.amazonaws.com/app-assets/calendar/empty-calendar.png',
                          message:
                              'Es probable que no haya horarios disponibles. Por favor intenta más tarde',
                          buttonText: 'Volver',
                          onButtonPressed: () {
                            context.pop();
                          });
                    } else {
                      return Flexible(
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
                              Column(
                                children: [
                                  ViewMonth(
                                    calendarFormat: calendarFormat,
                                    onToggle: (calendarFormat) {
                                      setState(() {
                                        this.calendarFormat = calendarFormat;
                                      });
                                    },
                                  ),
                                  ClassPicker(
                                    calendarFormat: calendarFormat,
                                    classList: classProvider.listClass,
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
                                      userClassList:
                                          classProvider.listClassFilter,
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
                                      text: 'Crear Cita',
                                      color: AppColors.brown200,
                                      onPressed: () async {
                                        if (classProvider.selectedClass ==
                                            null) {
                                          CustomSnackBar.show(
                                              context,
                                              'Por favor selecciona un día y hora',
                                              SnackBarType.error);
                                          return;
                                        }
                                        await classProvider
                                            .createClass(context);
                                      },
                                    ),
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: const ClientNavBar(),
        ),
        const AppLoading(),
      ],
    );
  }
}
