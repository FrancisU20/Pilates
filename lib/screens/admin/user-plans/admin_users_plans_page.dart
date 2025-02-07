import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/models/common/update_status_model.dart';
import 'package:pilates/models/user-plan/user_plan_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/admin/admin_nav_bar.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/components/common/custom_app_bar.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_icon_button.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class AdminUsersPlansPage extends StatefulWidget {
  const AdminUsersPlansPage({super.key});

  @override
  AdminUsersPlansPageState createState() => AdminUsersPlansPageState();
}

class AdminUsersPlansPageState extends State<AdminUsersPlansPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AdminProvider adminProvider =
          Provider.of<AdminProvider>(context, listen: false);
      adminProvider.reset();
      adminProvider.setIsActive(true);
      adminProvider.cleanSelectedUserId();
      await adminProvider.getUsersPlans(context, status: 'A');
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
                dataExtractor: (adminProvider) => adminProvider.listUserPlans
                    .map((userPlan) => userPlan.user)
                    .fold<Map<String, UserModel>>({}, (map, user) {
                      map[user.id!] = user;
                      return map;
                    })
                    .values
                    .toList(),
                searchField: (user) => user.dniNumber,
                onTap: (user) async{
                  AdminProvider adminProvider =
                      Provider.of<AdminProvider>(context, listen: false);
                  await adminProvider.onUserSelectedPlans(
                      context, adminProvider.isActive ? 'A' : 'I', user.id);
                },
              ),
              body: Container(
                color: AppColors.brown200,
                child: Column(
                  children: [
                    const CustomPageHeader(
                        icon: FontAwesomeIcons.addressBook,
                        title: 'Usuarios y Planes',
                        subtitle: 'Agenda de usuarios y planes'),
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
                                    adminProvider.setIsActive(true);
                                    adminProvider.cleanSelectedUserId();
                                    //? Aqui va el get con filtro solo (A)
                                    await adminProvider.getUsersPlans(context,
                                        status: 'A');
                                  },
                                  text: 'Activos',
                                  color: adminProvider.isActive
                                      ? AppColors.gold100
                                      : AppColors.white100),
                              CustomTextButton(
                                  onPressed: () async{
                                    adminProvider.setIsActive(false);
                                    adminProvider.cleanSelectedUserId();
                                    //? Aqui va el get con filtro (C), (E), (X)
                                    await adminProvider.getUsersPlans(context,
                                        status: 'I');
                                  },
                                  text: 'Inactivos',
                                  color: !adminProvider.isActive
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
                        if (adminProvider.listUserPlans.isEmpty) {
                          return const AppEmptyData(
                            imagePath:
                                'https://curvepilates-bucket.s3.amazonaws.com/app-assets/users/empty_users.png',
                            message: 'No se encontraron usuarios',
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
                                itemCount: adminProvider.listUserPlans.length,
                                itemBuilder: (BuildContext context, int index) {
                                  List<UserPlanModel> listUserPlan =
                                      adminProvider.listUserPlans;
                                  return Column(
                                    children: [
                                      if (index == 0 &&
                                          adminProvider
                                              .selectedUserId.isNotEmpty) ...[
                                        IconButton(
                                            onPressed: () {
                                              adminProvider
                                                  .cleanSelectedUserId();
                                              adminProvider.getUsersPlans(
                                                  context,
                                                  status: adminProvider.isActive
                                                      ? 'A'
                                                      : 'I');
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.circleXmark,
                                                color: AppColors.red300)),
                                      ],
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(5),
                                          ),
                                          CustomText(
                                            text: listUserPlan[index]
                                                .user
                                                .dniNumber,
                                            color: AppColors.black100,
                                            fontSize: SizeConfig.scaleText(3),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(4),
                                          ),
                                          CustomText(
                                            text: listUserPlan[index]
                                                        .user
                                                        .gender ==
                                                    'M'
                                                ? 'Hombre'
                                                : listUserPlan[index]
                                                            .user
                                                            .gender ==
                                                        'F'
                                                    ? 'Mujer'
                                                    : 'LGBTQ+',
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
                                            CustomImageNetwork(
                                              imagePath: listUserPlan[index]
                                                  .user
                                                  .photo,
                                              height:
                                                  SizeConfig.scaleHeight(12),
                                              width:
                                                  SizeConfig.scaleWidth(18),
                                            ),
                                            SizedBox(
                                              width: SizeConfig.scaleWidth(5),
                                            ),
                                            SizedBox(
                                              width: SizeConfig.scaleWidth(40),
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
                                                        '${listUserPlan[index].user.name} ${listUserPlan[index].user.lastname}',
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
                                                      text: listUserPlan[index]
                                                          .plan
                                                          .name,
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
                                                      text: listUserPlan[index]
                                                          .plan
                                                          .description,
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
                                                      text:
                                                          '${(listUserPlan[index].plan.classesCount - listUserPlan[index].scheduledClasses)} disponibles de ${listUserPlan[index].plan.classesCount}',
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      SizeConfig.scaleWidth(2),
                                                ),
                                                CustomIconButton(
                                                    color: AppColors.black100,
                                                    height: 5,
                                                    width: 10,
                                                    icon: FontAwesomeIcons
                                                        .fileInvoiceDollar,
                                                    onPressed: () {
                                                      AppDialogs.showInvoice(
                                                          context,
                                                          listUserPlan[index]
                                                              .paymentPhoto);
                                                    }),
                                                SizedBox(
                                                  height:
                                                      SizeConfig.scaleHeight(2),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      String newStatus =
                                                          listUserPlan[index]
                                                                      .status ==
                                                                  'A'
                                                              ? 'I'
                                                              : 'A';

                                                      UserPlanModel userPlan =
                                                          listUserPlan[index];

                                                      UpdateStatusModel
                                                          updateStatus =
                                                          UpdateStatusModel(
                                                        status: newStatus,
                                                      );

                                                      await adminProvider
                                                          .updateStatusUserPlan(
                                                              context,
                                                              userPlan,
                                                              updateStatus);

                                                      if (!context.mounted) {
                                                        return;
                                                      }

                                                      adminProvider.setIsActive(
                                                          newStatus == 'A'
                                                              ? true
                                                              : false);

                                                      adminProvider
                                                          .cleanSelectedUserId();

                                                      await adminProvider
                                                          .getUsersPlans(
                                                              context,
                                                              status:
                                                                  newStatus);
                                                    },
                                                    icon: Icon(
                                                      listUserPlan[index]
                                                                  .status ==
                                                              'A'
                                                          ? FontAwesomeIcons
                                                              .toggleOn
                                                          : FontAwesomeIcons
                                                              .toggleOff,
                                                      color: listUserPlan[index]
                                                                  .status ==
                                                              'A'
                                                          ? AppColors.green200
                                                          : AppColors.red300,
                                                      size: SizeConfig
                                                          .scaleHeight(3.5),
                                                    )),
                                              ],
                                            )
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
