import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/integrations/maps_launcher.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/custom_app_bar.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_icon_button.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class UserClassPage extends StatefulWidget {
  const UserClassPage({super.key});

  @override
  UserClassPageState createState() => UserClassPageState();
}

class UserClassPageState extends State<UserClassPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserClassProvider userClassProvider =
          Provider.of<UserClassProvider>(context, listen: false);
      userClassProvider.setIsHistory(false);
      await userClassProvider.getUserClass(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
              backgroundColor: AppColors.white100,
              appBar: const CustomAppBar(
                backgroundColor: AppColors.brown200,
              ),
              body: Container(
                color: AppColors.brown200,
                child: Column(
                  children: [
                    const CustomPageHeader(
                        icon: FontAwesomeIcons.calendarCheck,
                        title: 'Citas',
                        subtitle: 'Qué tenemos para ti hoy?'),
                    SizedBox(
                      height: SizeConfig.scaleHeight(2),
                    ),
                    Consumer<UserClassProvider>(
                      builder: (context, userClassProvider, child) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColors.black100,
                              borderRadius: BorderRadius.circular(20)),
                          width: SizeConfig.scaleWidth(90),
                          height: SizeConfig.scaleHeight(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextButton(
                                  onPressed: () async {
                                    userClassProvider.setIsHistory(false);
                                    //? Aqui va el get con filtro solo (A)
                                    await userClassProvider
                                        .getUserClass(context);
                                  },
                                  text: 'Agendadas',
                                  color: !userClassProvider.isHistory
                                      ? AppColors.gold100
                                      : AppColors.white100),
                              CustomTextButton(
                                  onPressed: () async {
                                    userClassProvider.setIsHistory(true);
                                    //? Aqui va el get con filtro (C), (E), (X)
                                    await userClassProvider
                                        .getUserClass(context);
                                  },
                                  text: 'Historial',
                                  color: userClassProvider.isHistory
                                      ? AppColors.gold100
                                      : AppColors.white100),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(2),
                    ),
                    Consumer<UserClassProvider>(
                      builder: (context, userClassProvider, child) {
                        if (userClassProvider.listUserClass.isEmpty &&
                                !userClassProvider.isHistory ||
                            userClassProvider.listUserClassHistory.isEmpty &&
                                userClassProvider.isHistory) {
                          return const AppEmptyData(
                            imagePath:
                                'https://curvepilates-bucket.s3.amazonaws.com/app-assets/calendar/empty-calendar.png',
                            message: 'No se encontraron citas',
                          );
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
                              child: ListView.builder(
                                itemCount: userClassProvider.isHistory
                                    ? userClassProvider
                                        .listUserClassHistory.length
                                    : userClassProvider.listUserClass.length,
                                itemBuilder: (BuildContext context, int index) {
                                  List<UserClassModel> listUserClass =
                                      userClassProvider.isHistory
                                          ? userClassProvider
                                              .listUserClassHistory
                                          : userClassProvider.listUserClass;

                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(5),
                                          ),
                                          CustomText(
                                            text:
                                                '${listUserClass[index].classModel.schedule!.startHour.substring(0, 5)} ${userClassProvider.getAMFM(listUserClass[index].classModel.schedule!.startHour.substring(0, 5))}',
                                            color: AppColors.black100,
                                            fontSize: SizeConfig.scaleText(3),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(4),
                                          ),
                                          CustomText(
                                            text: '50 min',
                                            color: AppColors.grey200,
                                            fontSize: SizeConfig.scaleText(1.8),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            SizeConfig.scaleWidth(5),
                                            SizeConfig.scaleHeight(2),
                                            0,
                                            SizeConfig.scaleHeight(2)),
                                        width: SizeConfig.scaleWidth(90),
                                        height: SizeConfig.scaleHeight(20),
                                        decoration: BoxDecoration(
                                            color: AppColors.white200,
                                            border: Border.all(
                                              color: AppColors.black100
                                                  .withOpacity(0.1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.black100
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(0, 1),
                                              ),
                                            ]),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: SizeConfig.scaleWidth(21),
                                              height:
                                                  SizeConfig.scaleHeight(10.5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              padding: EdgeInsets.all(
                                                  SizeConfig.scaleHeight(2)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      text: listUserClass[index]
                                                          .classModel
                                                          .classDate
                                                          .substring(8, 10)
                                                          .toString(),
                                                      color: AppColors.black100,
                                                      fontSize: SizeConfig
                                                          .scaleHeight(3),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            0.5),
                                                  ),
                                                  CustomText(
                                                      text: userClassProvider
                                                          .getStringMonth(
                                                              DateTime.parse(
                                                                  listUserClass[
                                                                          index]
                                                                      .classModel
                                                                      .classDate)),
                                                      color: AppColors.black100,
                                                      fontSize: SizeConfig
                                                          .scaleHeight(1.5),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeConfig.scaleWidth(5),
                                            ),
                                            SizedBox(
                                              width: userClassProvider.isHistory
                                                  ? SizeConfig.scaleWidth(35)
                                                  : SizeConfig.scaleWidth(40),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      text: 'Datos:',
                                                      color: AppColors.black100,
                                                      fontSize: SizeConfig
                                                          .scaleHeight(1.5),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            0.5),
                                                  ),
                                                  CustomText(
                                                    text:
                                                        '${listUserClass[index].user.name} ${listUserClass[index].user.lastname}',
                                                    color: AppColors.grey200,
                                                    fontSize:
                                                        SizeConfig.scaleHeight(
                                                            1.5),
                                                    fontWeight: FontWeight.w400,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            0.5),
                                                  ),
                                                  CustomText(
                                                      text: listUserClass[index]
                                                          .user
                                                          .dniNumber,
                                                      color: AppColors.grey200,
                                                      fontSize: SizeConfig
                                                          .scaleHeight(1.5),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            0.5),
                                                  ),
                                                  CustomText(
                                                      text: listUserClass[index]
                                                                  .user
                                                                  .gender ==
                                                              'M'
                                                          ? 'Hombre'
                                                          : listUserClass[index]
                                                                      .user
                                                                      .gender ==
                                                                  'F'
                                                              ? 'Mujer'
                                                              : 'LGBTQ+',
                                                      color: AppColors.grey200,
                                                      fontSize: SizeConfig
                                                          .scaleHeight(1.5),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textAlign:
                                                          TextAlign.start),
                                                ],
                                              ),
                                            ),
                                            if (userClassProvider.isHistory ==
                                                false) ...[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.scaleWidth(
                                                            2),
                                                  ),
                                                  CustomIconButton(
                                                      color: AppColors.black100,
                                                      height: 5,
                                                      width: 10,
                                                      icon: FontAwesomeIcons
                                                          .locationDot,
                                                      onPressed: () {
                                                        double latitude =
                                                            0.34291;
                                                        double longitude =
                                                            -78.1352;
                                                        String name =
                                                            'Curve Pilates';
                                                        mapServices.openMaps(
                                                            latitude: latitude,
                                                            longitude:
                                                                longitude,
                                                            name: name);
                                                      }),
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            2),
                                                  ),
                                                  Consumer<UserPlanProvider>(
                                                    builder: (context,
                                                        userPlanProvider,
                                                        child) {
                                                      DateTime now = DateTime.now().toLocal();

                                                      DateTime classDate =
                                                          DateTime.parse(
                                                              listUserClass[
                                                                      index]
                                                                  .classModel
                                                                  .classDate);

                                                      int classStartHour =
                                                          int.parse(
                                                              listUserClass[
                                                                      index]
                                                                  .classModel
                                                                  .schedule!
                                                                  .startHour
                                                                  .substring(
                                                                      0, 2));

                                                      int classStartMinute =
                                                          int.parse(
                                                              listUserClass[
                                                                      index]
                                                                  .classModel
                                                                  .schedule!
                                                                  .startHour
                                                                  .substring(
                                                                      3, 5));

                                                      int classEndHour =
                                                          int.parse(
                                                              listUserClass[
                                                                      index]
                                                                  .classModel
                                                                  .schedule!
                                                                  .endHour
                                                                  .substring(
                                                                      0, 2));

                                                      int classEndMinute =
                                                          int.parse(
                                                              listUserClass[
                                                                      index]
                                                                  .classModel
                                                                  .schedule!
                                                                  .endHour
                                                                  .substring(
                                                                      3, 5));

                                                      DateTime classDateStart =
                                                          DateTime(
                                                              classDate.year,
                                                              classDate.month,
                                                              classDate.day,
                                                              classStartHour,
                                                              classStartMinute).toLocal();

                                                      DateTime classDateEnd =
                                                          DateTime(
                                                              classDate.year,
                                                              classDate.month,
                                                              classDate.day,
                                                              classEndHour,
                                                              classEndMinute).toLocal();

                                                      //! canCheck se activa si now esta entre la hora de inicio y fin de la clase
                                                      bool canCheck = now.isAfter(
                                                              classDateStart) &&
                                                          now.isBefore(
                                                              classDateEnd);

                                                      if (canCheck) {
                                                        return CustomIconButton(
                                                          color: AppColors
                                                              .green200,
                                                          height: 5,
                                                          width: 10,
                                                          icon: FontAwesomeIcons
                                                              .check,
                                                          onPressed: () {
                                                            AppDialogs
                                                                .showConfirmAttendance(
                                                                    context,
                                                                    listUserClass[
                                                                            index]
                                                                        .id!);
                                                          },
                                                        );
                                                      } else if (!canCheck) {
                                                        return CustomIconButton(
                                                          color:
                                                              AppColors.red300,
                                                          height: 5,
                                                          width: 10,
                                                          icon: FontAwesomeIcons
                                                              .xmark,
                                                          onPressed: () {
                                                            AppDialogs
                                                                .showCancelDate(
                                                              context,
                                                              listUserClass[
                                                                      index]
                                                                  .id!,
                                                              DateTime.parse(
                                                                  listUserClass[
                                                                          index]
                                                                      .classModel
                                                                      .classDate
                                                                      .toString()),
                                                              int.parse(
                                                                  listUserClass[
                                                                          index]
                                                                      .classModel
                                                                      .schedule!
                                                                      .startHour
                                                                      .substring(
                                                                          0,
                                                                          2)),
                                                              int.parse(
                                                                  listUserClass[
                                                                          index]
                                                                      .classModel
                                                                      .schedule!
                                                                      .startHour
                                                                      .substring(
                                                                          3,
                                                                          5)),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        return const SizedBox
                                                            .shrink();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              )
                                            ] else if (userClassProvider
                                                    .isHistory ==
                                                true) ...[
                                              Transform.rotate(
                                                angle: -3.14 / 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: listUserClass[index]
                                                                .status ==
                                                            'C'
                                                        ? AppColors.green200
                                                        : listUserClass[index]
                                                                    .status ==
                                                                'E'
                                                            ? AppColors
                                                                .orange300
                                                            : listUserClass[index]
                                                                        .status ==
                                                                    'X'
                                                                ? AppColors
                                                                    .red300
                                                                : AppColors
                                                                    .black100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        SizeConfig.scaleWidth(
                                                            2),
                                                    horizontal:
                                                        SizeConfig.scaleWidth(
                                                            2),
                                                  ),
                                                  child: CustomText(
                                                    text: listUserClass[index]
                                                                .status ==
                                                            'C'
                                                        ? 'Completada'
                                                        : listUserClass[index]
                                                                    .status ==
                                                                'E'
                                                            ? 'Expirada'
                                                            : listUserClass[index]
                                                                        .status ==
                                                                    'X'
                                                                ? 'Cancelada'
                                                                : '',
                                                    color: AppColors.white100,
                                                    fontSize:
                                                        SizeConfig.scaleWidth(
                                                            3),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(2),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: const ClientNavBar()),
          const AppLoading(),
        ],
      ),
    );
  }
}
