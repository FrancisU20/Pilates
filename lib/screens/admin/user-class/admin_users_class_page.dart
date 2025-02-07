import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/screens/admin/user-class/widgets/user_class_metrics.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/admin/admin_nav_bar.dart';
import 'package:pilates/theme/components/common/custom_app_bar.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class AdminUserClassPage extends StatefulWidget {
  const AdminUserClassPage({super.key});

  @override
  AdminUserClassPageState createState() => AdminUserClassPageState();
}

class AdminUserClassPageState extends State<AdminUserClassPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AdminProvider adminProvider =
          Provider.of<AdminProvider>(context, listen: false);
      adminProvider.setIsHistory(false);
      adminProvider.cleanSelectedUserId();
      await adminProvider.getUsersClass(context);
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
              appBar: CustomAppBar<AdminProvider>(
                backgroundColor: AppColors.brown200,
                dataExtractor: (adminProvider) => adminProvider
                    .listUserClassFiltered
                    .map((userClass) => userClass
                        .user) // Extrae el modelo `UserModel` de cada objeto
                    .fold<Map<String, UserModel>>({}, (map, user) {
                      map[user.id!] =
                          user; // Usa `id` como clave para garantizar unicidad
                      return map;
                    })
                    .values
                    .toList(),
                searchField: (user) => user.dniNumber,
                onTap: (user) {
                  AdminProvider adminProvider =
                      Provider.of<AdminProvider>(context, listen: false);
                  adminProvider.onUserSelectedClass(context, user.id);
                },
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
                    Consumer<AdminProvider>(
                      builder: (context, adminProvider, child) {
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
                                  onPressed: () async{
                                    adminProvider.setIsHistory(false);
                                    //? Aqui va el get con filtro solo (A)
                                    adminProvider.cleanSelectedUserId();
                                    await adminProvider.getUsersClass(context);
                                  },
                                  text: 'Agendadas',
                                  color: !adminProvider.isHistory
                                      ? AppColors.gold100
                                      : AppColors.white100),
                              CustomTextButton(
                                  onPressed: () async{
                                    adminProvider.setIsHistory(true);
                                    //? Aqui va el get con filtro (C), (E), (X)
                                    adminProvider.cleanSelectedUserId();
                                    await adminProvider.getUsersClass(context);
                                  },
                                  text: 'Historial',
                                  color: adminProvider.isHistory
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
                    Consumer<AdminProvider>(
                      builder: (context, adminProvider, child) {
                        if (adminProvider.listUserClassFiltered.isEmpty) {
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
                                itemCount:
                                    adminProvider.listUserClassFiltered.length,
                                itemBuilder: (BuildContext context, int index) {
                                  List<UserClassModel> listUserClass =
                                      adminProvider.listUserClassFiltered;
                                  return Column(
                                    children: [
                                      if (index == 0 &&
                                          adminProvider
                                              .selectedUserId.isNotEmpty) ...[
                                        IconButton(
                                            onPressed: () {
                                              adminProvider
                                                  .cleanSelectedUserId();
                                              adminProvider
                                                  .getUsersClass(context);
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.circleXmark,
                                                color: AppColors.red300)),
                                      ],
                                      if (index == 0) ...[
                                        UserClassMetrics(
                                          listUserClass: listUserClass,
                                          isHistory: adminProvider.isHistory,
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                        adminProvider.selectedUserId.isNotEmpty
                                            ? CustomText(
                                                text:
                                                    'Citas de ${listUserClass[index].user.name} ${listUserClass[index].user.lastname}',
                                                color: AppColors.grey200,
                                                fontSize:
                                                    SizeConfig.scaleText(1.8),
                                                fontWeight: FontWeight.w600,
                                              )
                                            : CustomText(
                                                text: 'Citas Totales',
                                                color: AppColors.grey200,
                                                fontSize:
                                                    SizeConfig.scaleText(1.8),
                                                fontWeight: FontWeight.w600,
                                              ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                      ],
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(5),
                                          ),
                                          CustomText(
                                            text:
                                                '${listUserClass[index].classModel.schedule!.startHour.substring(0, 5)} ${adminProvider.getAMFM(listUserClass[index].classModel.schedule!.startHour.substring(0, 5))}',
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
                                            fontSize:
                                                SizeConfig.scaleHeight(1.8),
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
                                        height: SizeConfig.scaleHeight(15),
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
                                                      text: adminProvider
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
                                              width: adminProvider.isHistory
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
                                            if (adminProvider.isHistory ==
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
              bottomNavigationBar: const AdminNavBar()),
          const AppLoading(),
        ],
      ),
    );
  }
}
